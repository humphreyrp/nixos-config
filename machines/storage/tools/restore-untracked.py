#!/usr/bin/env python

import argparse
from pathlib import Path
import os

if __name__ == '__main__':

    parser = argparse.ArgumentParser(
                    prog='PruneUntracked',
                    description='Prunes the untracked files from the immich upload directory and \
                                 moves to a location of your choice',
                    formatter_class=argparse.ArgumentDefaultsHelpFormatter)

    parser.add_argument('--immich-dir', required=True, help='Immich API port')
    parser.add_argument('--dry-run', default=False, help='Check for untracked files but do not move anything')
    args = parser.parse_args()

    immich_dir = Path(args.immich_dir)
    upload_dir = immich_dir / "upload"
    untracked_dir = immich_dir / "untracked"

    untracked_paths = set()
    for root, dirs, files in os.walk(untracked_dir):
        for file in files:
            full_path = Path(os.path.join(root, file))
            untracked_paths.add(full_path)

    for p in untracked_paths:
        if ".MOV" in str(p):
            new_path = upload_dir / p.relative_to(untracked_dir)
            new_dir = os.path.dirname(new_path)
            print(f"{p} -> {new_path}")

            if not args.dry_run:
                if new_dir and not os.path.exists(new_dir):
                    os.makedirs(new_dir, exist_ok=True)
                p.rename(new_path)
