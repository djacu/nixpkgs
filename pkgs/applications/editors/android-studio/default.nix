{ callPackage, makeFontsConf, buildFHSEnv, tiling_wm ? false }:

let
  mkStudio = opts: callPackage (import ./common.nix opts) {
    fontsConf = makeFontsConf {
      fontDirectories = [];
    };
    inherit buildFHSEnv;
    inherit tiling_wm;
  };
  stableVersion = {
    version = "2024.1.2.12"; # "Android Studio Koala Feature Drop | 2024.1.2"
    sha256Hash = "sha256-dFFogg6YmpCF/4QtR85UFAfbCd97irIHcPbqieQabpI=";
  };
  betaVersion = {
    version = "2024.1.2.11"; # "Android Studio Koala Feature Drop | 2024.1.2 RC 1"
    sha256Hash = "sha256-Qn5NNW2Rt6f9QiEUamIumme45uUVeTiMJ/9niAC6ilM=";
  };
  latestVersion = {
    version = "2024.2.1.5"; # "Android Studio Ladybug | 2024.2.1 Canary 9"
    sha256Hash = "sha256-0F07jcsutarm464ahgo9hDh1jHo2aDEpIz5r9bxmNZw=";
  };
in {
  # Attributes are named by their corresponding release channels

  stable = mkStudio (stableVersion // {
    channel = "stable";
    pname = "android-studio";
  });

  beta = mkStudio (betaVersion // {
    channel = "beta";
    pname = "android-studio-beta";
  });

  dev = mkStudio (latestVersion // {
    channel = "dev";
    pname = "android-studio-dev";
  });

  canary = mkStudio (latestVersion // {
    channel = "canary";
    pname = "android-studio-canary";
  });
}
