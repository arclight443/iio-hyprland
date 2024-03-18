# iio-hyprland
A fork of okeri/iio-sway for Hyprland

Listens to iio-sensor-proxy and automatically changes Hyprland output orientation

## Installing

:warning: Make sure [iio-sensor-proxy](https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/) running :warning:

### Arch linux

`yay iio-hyprland-git`

`paru iio-hyprland-git`


### NixOS

Put this into your `flake.nix`
```nix
# flake.nix
inputs = {
  # ...
  iio-hyprland.url = "github:arclight443/iio-hyprland";
}
```

Then install the package to your system
```nix
# configuration.nix

# Don't forget to pass `inputs`
{ inputs, options, config, lib , pkgs, ... }:
# ...

  # Enable iio-sensor-proxy
  hardware.sensor.iio.enable = true;

  # Install package
  environment.systemPackages = with pkgs; [
    # ...
    inputs.iio-hyprland.defaultPackage.${pkgs.system}
  ];

#...
```


### Build from scratch

```
git clone https://github.com/JeanSchoeller/iio-hyprland

cd iio-hyprland

sudo make install
```

#### Uninstalling 
```
cd iio-hyprland

sudo make uninstall
```

## Running
`iio-hyprland [monitor to rotate, default=eDP-1]`, run `hyprctl monitors` to list available outputs.

Add `exec-once = iio-hyprland` to `~/.config/hypr/hyprland.conf`

Some users reported that specifying the monitor in hyprland.conf could be necessary. For example, on Surface Pro:

`monitor=eDP-1,preferred,auto,2,transform,0`

## Touch rotation support

Should automatically rotate all Tablets and Touch Devices from `hyprctl devices`.

Hyprland 0.37.0 added `input:touchdevice` and `input:tablet` category to variables, which allows us to rotate all touch inputs at once without needing to loop touch inputs manually.

Thank you to Desktop31 for fetching the `hyprctl devices` output.

