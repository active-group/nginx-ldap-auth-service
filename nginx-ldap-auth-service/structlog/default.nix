{ lib, python3 }:

python3.pkgs.buildPythonApplication rec {
  pname = "structlog";
  version = "23.1.0";
  pyproject = true;

  src = python3.pkgs.fetchPypi {
    inherit pname version;
    hash = "sha256-Jw1oHdfRY8EbpQC8kUskctK1Co7wD6qZne1f+DovkGs=";
  };

  nativeBuildInputs = [
    python3.pkgs.hatch-fancy-pypi-readme
    python3.pkgs.hatch-vcs
    python3.pkgs.hatchling
  ];

  propagatedBuildInputs = with python3.pkgs; [
    importlib-metadata
    typing-extensions
  ];

  passthru.optional-dependencies = with python3.pkgs; {
    dev = [ structlog ];
    docs = [
      furo
      myst-parser
      sphinx
      sphinx-notfound-page
      sphinxcontrib-mermaid
      twisted
    ];
    tests = [
      coverage
      freezegun
      pretend
      pytest
      pytest-asyncio
      simplejson
    ];
    typing = [
      mypy
      rich
      twisted
    ];
  };

  pythonImportsCheck = [ "structlog" ];

  meta = with lib; {
    description = "Structured Logging for Python";
    homepage = "https://pypi.org/project/structlog/";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "structlog";
  };
}
