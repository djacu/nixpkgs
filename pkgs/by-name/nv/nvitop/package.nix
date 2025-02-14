{
  lib,
  python3Packages,
  fetchFromGitHub,
  versionCheckHook,
}:

python3Packages.buildPythonApplication rec {
  pname = "nvitop";
  version = "1.4.0";

  src = fetchFromGitHub {
    owner = "XuehaiPan";
    repo = "nvitop";
    tag = "v${version}";
    hash = "sha256-Z0JGW7vcZFxguQqhqhpPpOvcOct7B9z8RoEFu5NsOl0=";
  };

  pythonRelaxDeps = [ "nvidia-ml-py" ];

  dependencies = with python3Packages; [
    cachetools
    psutil
    termcolor
    nvidia-ml-py
  ];

  nativeCheckInputs = [
    versionCheckHook
  ];
  versionCheckProgramArg = [ "--version" ];

  meta = {
    description = "Interactive NVIDIA-GPU process viewer, the one-stop solution for GPU process management";
    homepage = "https://github.com/XuehaiPan/nvitop";
    changelog = "https://github.com/XuehaiPan/nvitop/releases/tag/v${version}";
    license = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [ GaetanLepage ];
    platforms = with lib.platforms; linux;
  };
}
