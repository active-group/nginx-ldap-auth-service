{ lib, python3 }:

python3.pkgs.buildPythonApplication rec {
  pname = "starsessions";
  version = "2.1.3";
  pyproject = true;

  src = python3.pkgs.fetchPypi {
    inherit pname version;
    hash = "sha256-0gxfJ3tkqGwWgZ9lrFCBTM29FGd2FZ4IyIs3i2YSKX0=";
  };

  nativeBuildInputs = [ python3.pkgs.poetry-core ];

  propagatedBuildInputs = with python3.pkgs; [
    itsdangerous
    starlette
  ];

  passthru.optional-dependencies = with python3.pkgs; {
    redis = [ redis ];
  };

  pythonImportsCheck = [ "starsessions" ];

  meta = with lib; {
    description = "Advanced sessions for Starlette and FastAPI frameworks";
    homepage = "https://pypi.org/project/starsessions/";
    license = licenses.mit;
    maintainers = [ ];
    mainProgram = "starsessions";
  };
}
