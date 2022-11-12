{
  description = "Development environment";

  inputs = {
      nixpkgs = { url = "github:NixOS/nixpkgs/nixpkgs-unstable"; };
      flake-utils = { url = "github:numtide/flake-utils"; };
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        inherit (nixpkgs.lib) optional;
        pkgs = import nixpkgs {
          inherit system;
        };

      in
      {
        devShell = pkgs.mkShell
        {
          buildInputs =
            (with pkgs; [
              glibcLocales
              inotify-tools
              ansible_2_13
              # needed for emacs to unzip elixir-ls
              unzip
            ]);

            shellHook = ''
              mkdir -p .ansible
              export ANSIBLE_SSH_CONTROL_PATH_DIR=".ansible/cp"
              export ANSIBLE_ACTION_PLUGINS=".ansible/plugins/action"
              export ANSIBLE_CACHE_PLUGINS=".ansible/plugins/cache"
              export ANSIBLE_CALLBACK_PLUGINS=".ansible/plugins/callback"
              export ANSIBLE_CONNECTION_PLUGINS=".ansible/plugins/connection"
              export ANSIBLE_FILTER_PLUGINS=".ansible/plugins/filter"
              export ANSIBLE_INVENTORY_PLUGINS=".ansible/plugins/inventory"
              export ANSIBLE_LOCAL_TEMP=".ansible/tmp"
              export ANSIBLE_LOOKUP_PLUGINS=".ansible/plugins/lookup"
              export ANSIBLE_LIBRARY=".ansible/plugins/modules"
              export ANSIBLE_MODULE_UTILS=".ansible/plugins/module_utils"
              export ANSIBLE_ROLES_PATH=".ansible/roles"
              export ANSIBLE_STRATEGY_PLUGINS=".ansible/plugins/strategy"
              export ANSIBLE_TEST_PLUGINS=".ansible/plugins/test"
              export ANSIBLE_VARS_PLUGINS=".ansible/plugins/vars"
              export ANSIBLE_PERSISTENT_CONTROL_PATH_DIR=".ansible/pc"

              ${pkgs.ansible_2_13}/bin/ansible-galaxy install -r requirements.yml
            '';
        };
      }
    );
}
