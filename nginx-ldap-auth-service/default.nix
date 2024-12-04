{
  pkgs,
  ...
}:
let
  python3 = pkgs.python3;
  lib = pkgs.lib;
in
python3.pkgs.buildPythonApplication rec {
  pname = "nginx-ldap-auth-service";
  version = "2.0.5";
  pyproject = true;

  src = pkgs.fetchFromGitHub {
    owner = "caltechads";
    repo = "nginx-ldap-auth-service";
    rev = version;
    hash = "sha256-Julx4Sh8crgnnL1lrMeG2GWgXuRZ/TrIudnkV+036zQ=";
  };

  nativeBuildInputs = [
    python3.pkgs.setuptools
    python3.pkgs.wheel
  ];

  propagatedBuildInputs = with python3.pkgs; [
    (import ./aiodogstatsd { inherit lib python3; })
    (import ./bonsai { inherit lib python3 pkgs; })
    click
    fastapi
    jinja2
    pydantic
    pydantic-settings
    python-dotenv
    python-multipart
    sentry-sdk
    (import ./starsessions { inherit lib python3; })
    (import ./structlog { inherit lib python3; })
    tabulate
    (import ./uvicorn { inherit lib python3; })
    watchfiles
    redis
  ];

  meta = with lib; {
    description = "A FastAPI app that authenticates users via LDAP and sets a cookie for nginx";
    homepage = "https://pypi.org/project/nginx-ldap-auth-service/";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "nginx-ldap-auth-service";
  };

  postFixup = ''
    # ls -l $out/lib/python3.12/site-packages/nginx_ldap_auth/app/
    # exit 1
    cp -r nginx_ldap_auth/app/static $out/lib/python3.12/site-packages/nginx_ldap_auth/app/
    cp -r nginx_ldap_auth/app/templates $out/lib/python3.12/site-packages/nginx_ldap_auth/app/
  '';
}
