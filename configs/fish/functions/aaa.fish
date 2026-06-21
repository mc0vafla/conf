function aaa --wraps='cd /etc/nixos/; git add .; git commit -m 1; nh os boot .#mark --ask --impure && cd /home/mark/' --description 'alias aaa cd /etc/nixos/; git add .; git commit -m 1; nh os boot .#mark --ask --impure && cd /home/mark/'
    cd /etc/nixos/; git add .; git commit -m 1; nh os boot .#mark --ask --impure && cd /home/mark/ $argv
end
