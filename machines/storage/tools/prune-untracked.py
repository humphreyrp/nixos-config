#!/usr/bin/env python

import requests
import json
import os
from pathlib import Path
import argparse

if __name__ == '__main__':

    parser = argparse.ArgumentParser(
                    prog='PruneUntracked',
                    description='Prunes the untracked files from the immich upload directory and \
                                 moves to a location of your choice',
                    formatter_class=argparse.ArgumentDefaultsHelpFormatter)

    parser.add_argument('--immich-dir', required=True, help='Immich API port')
    parser.add_argument('--api-key')
    parser.add_argument('--host', default='localhost', help='Immich hostname')
    parser.add_argument('--port', default=2283, help='Immich API port')
    parser.add_argument('--dry-run', default=False, help='Check for untracked files but do not move anything')
    parser.add_argument('--print-responses', default=False, help='Prints the JSON object response when pulling assets')
    args = parser.parse_args()

    print("Retrieving all assets...")
    asset_stems = set()

    nextPage = 1
    count = 0
    stop = False
    while not stop:
        # Get the next page of assets
        if args.api_key is not None:
            headers = {"x-api-key": args.api_key}
        else:
            headers = {}

        endpoint = f"http://{args.host}:{args.port}/api/search/metadata"
        r = requests.post(endpoint, data={"page": nextPage}, headers=headers)

        if r.status_code != 200:
            raise Exception(f"Invalid response status: {r.status_code}")

        data = r.json()
        if args.print_responses:
            print(json.dumps(data, indent=4))

        if data["assets"]["items"]:
            count += data["assets"]["count"]
            for asset in data["assets"]["items"]:
                stem = Path(asset["originalPath"]).stem.split('.')[0]
                asset_stems.add(stem)

        if data["assets"]["nextPage"]:
            nextPage = data["assets"]["nextPage"]
        else:
            stop = True

    print(f"Retrieved {len(asset_stems)} assets.")

    count_tracked = 0
    immich_dir = Path(args.immich_dir)
    upload_path = immich_dir / "upload"
    untracked_dir = immich_dir / "untracked"

    print(f"Walking directory {upload_path}...")

    untracked_paths = set()
    for root, dirs, files in os.walk(upload_path):
        for file in files:
            full_path = Path(os.path.join(root, file))
            stem = full_path.stem.split('.')[0]
            if stem not in asset_stems:
                untracked_paths.add(full_path)
            else:
                count_tracked += 1

    print(f"Total untracked: {len(untracked_paths)}, Total tracked: {count_tracked}")

    if not args.dry_run:
        print(f"Moving assets from {immich_dir} to {untracked_dir}")
        for p in untracked_paths:
            new_path = untracked_dir / p.relative_to(upload_path)
            new_dir = os.path.dirname(new_path)
            if new_dir and not os.path.exists(new_dir):
                os.makedirs(new_dir, exist_ok=True)
            p.rename(new_path)
            print(f"{p} -> {new_path}")

