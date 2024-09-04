{
  lib,
  rustPlatform,
  fetchFromGitHub,
  curl,
  pkg-config,
  libgit2,
  openssl,
  zlib,
  stdenv,
  darwin,
}:

rustPlatform.buildRustPackage {
  pname = "oxide-rs";
  version = "0.7.0";

  src = fetchFromGitHub {
    owner = "djacu";
    repo = "oxide.rs";
    rev = "a4b9305178d5f871ed4061a349b83d1e87f5e5bf";
    hash = "sha256-npQnHsbP7s7CAz5GOXwvlwbgFDVHAATByrj6SRL4PB8=";
    leaveDotGit = true;
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "dropshot-0.11.1-dev" = "sha256-Im6+TUVe1jG0UM86K5VLLiThdyOWBMORniNyWdO2iS4=";
      "oxnet-0.1.0" = "sha256-RFTNKLR4JrNs09De8K+M35RDk/7Nojyl0B9d14O9tfM=";
      "thouart-0.1.0" = "sha256-GqSHyhDCqQCC8dCvXzsn2WMcNKJxJWXrTcR38Wr3T1s=";
    };
  };

  buildAndTestSubdir = "cli";

  nativeBuildInputs = [
    curl
    pkg-config
  ];

  buildInputs =
    [
      curl
      libgit2
      openssl
      zlib
    ]
    ++ lib.optionals stdenv.isDarwin [
      darwin.apple_sdk.frameworks.Security
      darwin.apple_sdk.frameworks.SystemConfiguration
    ];

  env = {
    OPENSSL_NO_VENDOR = true;
  };

  meta = with lib; {
    description = "The Oxide Rust SDK and CLI";
    homepage = "https://github.com/oxidecomputer/oxide.rs";
    license = licenses.mpl20;
    maintainers = with maintainers; [
      djacu
      sarcasticadmin
    ];
    mainProgram = "oxide-rs";
  };
}
