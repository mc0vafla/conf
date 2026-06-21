function dead --wraps='cd /etc/nixos/; deadnix' --description 'alias dead=cd /etc/nixos/; deadnix'
    cd /etc/nixos/; deadnix $argv
end
