function rute --wraps='sudo chown -R mark:users .' --description 'alias rute=sudo chown -R mark:users .'
    sudo chown -R mark:users . $argv
end
