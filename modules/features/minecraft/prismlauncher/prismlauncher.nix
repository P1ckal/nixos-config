# we'd want to use unwrapped so we can do glfw overrides
{ ... }: {
  flake.modules.homeManager.prismlauncher = { pkgs, ...}: {
    programs.prismlauncher = {
      enable = true;

      package = pkgs.prismlauncher.override {
        jdks = [pkgs.jdk8 pkgs.jdk17 pkgs.jdk21 pkgs.jdk25];
      };

      settings = {
        ApplicationTheme="dark";
        AutomaticJavaDownload=false;
        BackgroundCat="rory";
        ConfigVersion="1.3";
        IconTheme="pe_dark";
        Language="en_US";
        AutomaticJavaSwitch = true;
        JavaPath = "${pkgs.jdk21}/bin/java";
        MaxMemAlloc="9600";
        UseNativeGLFW=true;
        WrapperCommand="waywall wrap --";
      };
    };
  };
}
