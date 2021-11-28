{ hmUsers, config, self, lib, pkgs, ... }:
let
  inherit (builtins) toFile readFile;
  inherit (lib) fileContents mkForce;

  name = "Janus";

in
{
  imports = [ ./private/protected.nix ];
  age.secrets.janus.file = "${self}/secrets/janus.age";
  age.secrets.salusa.file = "${self}/secrets/salusa.age";
  users.groups.media.members = [ "janus" ];
  users.users.janus = {
    uid = 1000;
    passwordFile = "/run/secrets/janus";
    description = name;
    shell = pkgs.zsh;
    isNormalUser = true;
    group = "janus";
    extraGroups = [
      "wheel"
      "input"
      "networkmanager"
      "libvirtd"
      "video"
      "taskd"
    ];
    openssh = {
      authorizedKeys = {
        keyFiles = [ ./pubkey ];
      };
    };
  };
  # services.protonvpn = {
  #   enable = true;
  #   authentication.username = "john";
  #   authentication.password = "galt";
  #   server = "us-free-01.protonvpn.com";
  # };
  home-manager.users.janus = { suites, lib, nur, ... }: {
    imports = suites.graphics;
    home = {
      file = {
        #".zshrc".text = "#";
        ".gnupg/gpg-agent.conf".text = ''
          pinentry-program ${pkgs.pinentry_curses}/bin/pinentry-curses
        '';
      };
    };

    programs = {
      mpv = {
        enable = true;
        config = {
          ytdl-format = "bestvideo[height<=?1080]+bestaudio/best";
          hwdec = "auto";
          vo = "gpu";
        };
      };

      git = {
        userName = name;
        userEmail = "janus@dark.fi";
        # signing = {
        #   key = "8985725DB5B0C122";
        #   signByDefault = true;
        # };
      };

      ssh = {
        enable = true;
        hashKnownHosts = true;
        matchBlocks = {
          "darkfi.dev" = {
            host = "${config.networking.hostName}";
            identityFile = "/run/secrets/salusa";
            extraOptions = { AddKeysToAgent = "yes"; };
          };
        };
      };
    };

  };

}
