{ lib, python3 }:

python3.pkgs.buildPythonApplication rec {
  pname = "uvicorn";
  version = "0.21.1";
  pyproject = true;

  src = python3.pkgs.fetchPypi {
    inherit pname version;
    hash = "sha256-D6ycs0K6CZ4NWClmAF8/26WwKQV5/tSmJm3HAsp7sDI=";
  };

  nativeBuildInputs = [ python3.pkgs.hatchling ];

  propagatedBuildInputs = with python3.pkgs; [
    click
    h11
    typing-extensions
  ];

  passthru.optional-dependencies = with python3.pkgs; {
    standard = [
      colorama
      httptools
      python-dotenv
      pyyaml
      uvloop
      watchfiles
      websockets
    ];
  };

  pythonImportsCheck = [ "uvicorn" ];

  meta = with lib; {
    description = "The lightning-fast ASGI server";
    homepage = "https://pypi.org/project/uvicorn/0.21.1/";
    license = licenses.bsd3;
    maintainers = with maintainers; [ ];
    mainProgram = "uvicorn";
  };
}
