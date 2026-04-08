{
  lib,
  stdenv,
  python3Packages,
  fetchFromGitHub,
  # tests
  uv,
  versionCheckHook,
  writableTmpDirAsHomeHook,
}:
python3Packages.buildPythonApplication rec {
  pname = "mistral-vibe";
  version = "2.4.2";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "mistralai";
    repo = "mistral-vibe";
    rev = "095a67b0c73b512c1f4ff23ec8c7135276c8f3cc";
    hash = "sha256-r/9kMhkoLfj9oEifFun/bpIQYEouqm9YEiWZVk07+S8=";
  };

  nativeBuildInputs = with python3Packages; [
    editables
    hatch-vcs
    hatchling
  ];

  pythonRelaxDeps = [
    "agent-client-protocol"
    "cryptography"
    "gitpython"
    "mistralai"
    "pydantic-settings"
    "zstandard"
  ];
  propagatedBuildInputs = with python3Packages; [
    agent-client-protocol
    anyio
    cachetools
    cryptography
    gitpython
    giturlparse
    google-auth
    httpx
    keyring
    mcp
    markdownify
    mistralai
    packaging
    pexpect
    pydantic
    pydantic-settings
    pyperclip
    python-dotenv
    pyyaml
    requests
    rich
    textual
    textual-speedups
    tomli-w
    tree-sitter
    tree-sitter-bash
    watchfiles
    zstandard
  ];

  pythonImportsCheck = ["vibe"];

  nativeCheckInputs = [
    python3Packages.pytest-asyncio
    python3Packages.pytest-textual-snapshot
    python3Packages.pytest-xdist
    python3Packages.pytestCheckHook
    python3Packages.respx
    uv
    versionCheckHook
    writableTmpDirAsHomeHook
  ];
  versionCheckKeepEnvironment = ["HOME"];

  disabledTests = lib.optionals stdenv.hostPlatform.isDarwin [
    "test_rebuilds_index_when_mass_change_threshold_is_exceeded"
    "test_updates_index_incrementally_by_default"
    "test_updates_index_on_file_creation"
    "test_updates_index_on_file_deletion"
    "test_updates_index_on_file_rename"
    "test_updates_index_on_folder_rename"
    "test_watcher_toggle_flow_off_on_off"
  ];

  disabledTestPaths = [
    "tests/snapshots/"
    "tests/e2e/"
    "tests/acp/test_acp.py"
  ];

  meta = {
    description = "YOLO is an amazing and powerful tool that lets you easily train models for all your computer vision tasks.";
    homepage = "https://github.com/mistralai/mistral-vibe";
    changelog = "https://github.com/mistralai/mistral-vibe/blob/${version}/CHANGELOG.md";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [
      GaetanLepage
      shikanime
      mana-byte
    ];
    mainProgram = "vibe";
  };
}
