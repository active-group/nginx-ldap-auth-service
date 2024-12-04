{
  lib,
  python3,
  pkgs,
}:

python3.pkgs.buildPythonApplication rec {
  pname = "bonsai";
  version = "1.5.1";
  pyproject = true;

  src = python3.pkgs.fetchPypi {
    inherit pname version;
    hash = "sha256-EBsNFmNJvcv3ZKgTn9BrhbVSS0Ql4/K9bCOB+QNp9zU=";
  };

  nativeBuildInputs = [
    python3.pkgs.setuptools
    python3.pkgs.wheel
  ];

  buildInputs = [
    pkgs.cyrus_sasl
    pkgs.openldap
  ];

  propagatedBuildInputs = with python3.pkgs; [ typing-extensions ];

  passthru.optional-dependencies = with python3.pkgs; {
    gevent = [ gevent ];
    tornado = [ tornado ];
    trio = [ trio ];
  };

  pythonImportsCheck = [ "bonsai" ];

  meta = with lib; {
    description = "Python 3 module for accessing LDAP directory servers";
    homepage = "https://pypi.org/project/bonsai/";
    license = licenses.mit;
    maintainers = [ ];
    mainProgram = "bonsai";
  };
}
