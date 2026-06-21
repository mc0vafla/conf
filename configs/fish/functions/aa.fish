function aa --wraps='cd /etc/nixos/; git add .; git commit -m 1; nh os switch .#mark --ask --impure && cd /home/mark/' --description 'alias aa cd /etc/nixos/; git add .; git commit -m 1; nh os switch .#mark --ask --impure && cd /home/mark/'
    cd /etc/nixos/; git add .; git commit -m 1; nh os switch .#mark --ask --impure && cd /home/mark/ $argv
end
