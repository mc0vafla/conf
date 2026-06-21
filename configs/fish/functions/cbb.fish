function cbb --wraps='cargo build --release --target x86_64-unknown-linux-musl' --description 'alias cbb=cargo build --release --target x86_64-unknown-linux-musl'
    cargo build --release --target x86_64-unknown-linux-musl $argv
end
