function git-key --wraps='cat ~/.ssh/id_ed25519.pub' --description 'alias git-key=cat ~/.ssh/id_ed25519.pub'
    cat ~/.ssh/id_ed25519.pub $argv
end
