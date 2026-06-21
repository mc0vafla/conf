function 321 --wraps=reboot --wraps='sudo umount -l /dev/sda1 && sudo reboot' --description 'alias 321=reboot'
    reboot $argv
end
