function cb --wraps='cargo build --release' --description 'alias cb=cargo build --release'
    cargo build --release $argv
end
