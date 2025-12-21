{ python3Packages }:
with python3Packages;
buildPythonApplication {
  pname = "my-immich-tools";
  version = "1.0";
  pyproject = true;
  build-system = [ setuptools ];

  propagatedBuildInputs = [ requests ];

  src = ./.;
}
