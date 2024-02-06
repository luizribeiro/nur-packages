{ lib
, python3
, fetchFromGitLab
, ...
}:

python3.pkgs.buildPythonApplication rec {
  pname = "vja";
  version = "3.1.0";
  pyproject = true;

  src = fetchFromGitLab {
    owner = "ce72";
    repo = "vja";
    rev = version;
    hash = "sha256-bQnkn9Tvwp/krtyikxedr37ArP/ATDtEbZ89CHVG8eE=";
  };

  nativeBuildInputs = [
    python3.pkgs.setuptools
    python3.pkgs.wheel
  ];

  propagatedBuildInputs = with python3.pkgs; [
    click
    click-aliases
    requests
    parsedatetime
    python-dateutil
  ];

  pythonImportsCheck = [ "vja" ];

  meta = with lib; {
    description = "";
    homepage = "https://gitlab.com/ce72/vja/";
    changelog = "https://gitlab.com/ce72/vja/-/blob/${src.rev}/CHANGELOG.md";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ luizribeiro ];
    mainProgram = "vja";
  };
}
