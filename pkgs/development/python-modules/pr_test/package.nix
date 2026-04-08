{
  lib,
  stdenv,
  buildPythonPackage,
  fetchFromGitHub,

  # build-system
  setuptools,

  # dependencies
  lap,
  matplotlib,
  opencv-python,
  pandas,
  pillow,
  polars,
  psutil,
  py-cpuinfo,
  pyyaml,
  requests,
  scipy,
  seaborn,
  torch,
  torchvision,
  tqdm,
  ultralytics-thop,

  # tests
  aiohttp,
  onnx,
  onnxruntime,
  pytestCheckHook,
}:

buildPythonPackage rec {
  pname = "test_pr";
  version = "8.4.21";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "ultralytics";
    repo = "ultralytics";
    tag = "v${version}";
    hash = "sha256-KyTqO5jjYXnw5xwKlvwnY99SE0zkLaz8Ck6hKb7non8=";
  };

  nativeBuildInputs = [ setuptools ];

  pythonRelaxDeps = [
    "numpy"
  ];

  propagatedBuildInputs = [
    lap
    matplotlib
    opencv-python
    pandas
    pillow
    polars
    psutil
    py-cpuinfo
    pyyaml
    requests
    scipy
    scipy
    seaborn
    torch
    torchvision
    tqdm
    ultralytics-thop
  ];

  pythonImportsCheck = [ "ultralytics" ];

  nativeCheckInputs = [
    aiohttp
    onnx
    onnxruntime
    pytestCheckHook
  ];

  meta = {
    homepage = "https://github.com/ultralytics/ultralytics";
    changelog = "https://github.com/ultralytics/ultralytics/releases/tag/${src.tag}";
    description = "Train YOLO models for computer vision tasks";
    mainProgram = "yolo";
    license = lib.licenses.agpl3Only;
    maintainers = with lib.maintainers; [
      no
    ];
  };
}
