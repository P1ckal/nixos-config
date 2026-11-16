function rebuild --description 'rebuild system config'
    sudo nixos-rebuild switch --flake ~/nixos#framework13pro $argv
end
