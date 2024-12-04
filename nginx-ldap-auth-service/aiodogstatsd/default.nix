{ lib, python3 }:

python3.pkgs.buildPythonApplication rec {
  pname = "aiodogstatsd";
  version = "0.16.0.post0";
  pyproject = true;

  src = python3.pkgs.fetchPypi {
    inherit pname version;
    hash = "sha256-94PH1tdO3RYLNBQf9fBpyak1uzJjaCPjnjbw0dvhSTE=";
  };

  nativeBuildInputs = [ python3.pkgs.poetry-core ];

  passthru.optional-dependencies = with python3.pkgs; {
    aiohttp = [ aiohttp ];
    starlette = [ starlette ];
  };

  pythonImportsCheck = [ "aiodogstatsd" ];

  meta = with lib; {
    description = "An asyncio-based client for sending metrics to StatsD with support of DogStatsD extension";
    homepage = "https://pypi.org/project/aiodogstatsd/";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "aiodogstatsd";
  };
}
