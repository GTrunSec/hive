{
  services.kanshi = {
    enable = true;
    profiles = {
      docked = {
        outputs = [
          {
            criteria = "DP-2";
            position = "3840,0";
            scale = 2.1;
            mode = "3840x2160";
          }
        ];
      };
    };
    # systemdTarget = "graphical-session.target";
  };
}