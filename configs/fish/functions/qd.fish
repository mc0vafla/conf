function qd --wraps='cd /etc/nixos/; nh os test' --wraps='cd /etc/nixos/; nh os test; cd ~/' --wraps='cd /etc/nixos/; nh os test --dry; cd ~/' --description 'alias qd cd /etc/nixos/; nh os test --dry; cd ~/'
    cd /etc/nixos/; nh os test --dry; cd ~/ $argv
end
