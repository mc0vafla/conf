function c --wraps='clear; nix run ; tput input' --wraps='clear; tput input' --wraps='clear; tput' --wraps='tput clear' --wraps=tput --wraps='tput reset' --wraps='tput -x clear' --description 'alias c=tput -x clear'
    tput -x clear $argv
end
