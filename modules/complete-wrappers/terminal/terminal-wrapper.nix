{ self, ... }: {
  perSystem = { self', ... }: {
    packages.shell-wrapper = self'.packages.fish.wrap (
      (with self.modules.fish; [
        starship
        zoxide
        direnv
        lazygit
        helix
      ])
      ++ [
        ({ pkgs, lib, ... }: {
          prefixVar = [
            [
              "PATH"
              ":"
              (lib.makeBinPath (
                (with self'.packages; [
                  helix
                  btop
                  lazygit
                  hyfetch
                ])
                ++ (with pkgs; [
                  zoxide
                  direnv
                  ripgrep
                  fd
                  eza
                  bat
                  fzf
                ])
              ))
            ]
          ];
        })
      ]
    );

    packages.terminal = self'.packages.kitty.wrap [
      ({ lib, ... }: {
        settings.shell = lib.getExe self'.packages.shell-wrapper;
      })
    ];

    packages.default = self'.packages.terminal;
  };
}
