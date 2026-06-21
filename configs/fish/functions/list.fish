function list --wraps='nvd list | grep' --description 'alias list=nvd list | grep'
    nvd list | grep $argv
end
