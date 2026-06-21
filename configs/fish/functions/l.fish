function l --wraps='ls -alh' --wraps='lsd -alh' --description 'alias l=lsd -alh'
    lsd -alh $argv
end
