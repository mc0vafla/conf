set -x ZOXIDE_DATA_DIR "$HOME/.local/share/zoxide"
set -Ux GSK_RENDERER ngl
set -g fish_greeting ""
set -gx NV_prime_render_offload 1
set -gx __VK_LAYER_NV_optimus NVIDIA_only
set -gx __GLX_VENDOR_LIBRARY_NAME nvidia
set -gx __GL_GSYNC_ALLOWED 1
set -gx __GL_VRR_ALLOWED 1
set -gx WLR_DRM_NO_ATOMIC 1
set -gx MOZ_ENABLE_WAYLAND 1
set -gx ELECTRON_OZONE_PLATFORM_HINT wayland
set -gx XDG_CURRENT_DESKTOP niri
set -gx XDG_MENU_PREFIX gnome-
set -gx EDITOR nvim
set -gx TERM xterm-256color
set -gx PIPEWIRE_LATENCY "512/48000"
set -gx QT_QPA_PLATFORMTHEME qt6ct
set -gx STEAM_RUNTIME_PREFER_HOST_LIBRARIES 0

function unchimer
  sudo zpool export rpool
end

function chimer
  sudo zpool import -f -R /mnt/chimera rpool
end

function asciitwall 
    if test (count $argv) -lt 4
        echo "Not enough arguments"
        echo "Usage: asciitwall <text> <size> <text_color> <background_color>"
        echo "Example:        asciitwall \" \" 25 \"#928374\" \"#1D2021\""
        return 1
    end

    set -l text $argv[1]
    set -l size $argv[2]
    set -l fg_color $argv[3]
    set -l bg_color $argv[4]
    set -l font_path (fc-list : file | rg -m 1 'JetBrainsMonoNerdFont-Regular\.ttf' | cut -d: -f1)
    if test -z "$font_path"
        set font_path (fc-list : file | rg -m 1 -i 'jetbrains.*\.ttf' | cut -d: -f1)
    end
    if test -z "$font_path"
        echo "Error: Font JetBrains Mono not found in ur system."
        return 1
    end
    asciitextwall \
        -f standard \
        -mf "$font_path" \
        -t "$text" \
        -s "$size" \
        -c "$fg_color" \
        -b "$bg_color" \
        -iw 1920 \
        -ih 1080
end

function mm 
    if test (count $argv) -gt 0
        nvim $argv -c "lua vim.schedule(function() vim.cmd('Telescope find_files') end)"
    else
        nvim -c "lua vim.defer_fn(function() vim.cmd('Telescope find_files') end, 10)"
    end
end

if test "$USER" = "root"
    set -gx Z_DATA /root/.local/share/z/data
    set -gx _Z_DATA /root/.local/share/z/data
    command mkdir -p /root/.local/share/z 2>/dev/null
else
    set -gx Z_DATA /home/mark/.local/share/z/data
    set -gx _Z_DATA /home/mark/.local/share/z/data
    command mkdir -p /home/mark/.local/share/z 2>/dev/null
end

function fish_prompt
    set_color blue
    echo -n (prompt_pwd)
    set_color cyan
    echo -n " ❯ "
    set_color normal
end

function fish_right_prompt
    set -l now (date +%s)

    if test -z "$_nixos_git_next_check"; or test "$now" -ge "$_nixos_git_next_check"
        set -g _nixos_git_next_check (math "$now + 4")
        set -g _nixos_git_changed 0
        set -g _nixos_git_ahead 0

        if test -d /etc/nixos/.git
            if command git --no-optional-locks -C /etc/nixos status --porcelain 2>/dev/null | read -l dummy
                set -g _nixos_git_changed 1
            else
                if command git --no-optional-locks -C /etc/nixos status --branch --porcelain 2>/dev/null | head -n 1 | string match -q "*ahead*"
                    set -g _nixos_git_ahead 1
                end
            end
        end
    end
    set -l nixos_changed $_nixos_git_changed
    set -l nixos_ahead $_nixos_git_ahead

    if test -z "$_nixos_gen_next_check"; or test "$now" -ge "$_nixos_gen_next_check"
        set -g _nixos_gen_next_check (math "$now + 5")
        set -g _nixos_gen_count (command ls -d /nix/var/nix/profiles/system-*-link 2>/dev/null | count)
    end
    set -l gen_count $_nixos_gen_count

    set -l real_pwd (realpath $PWD 2>/dev/null; or echo $PWD)

    set -l git_branch ""
    if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set git_branch (command git branch --show-current 2>/dev/null)
        if test -z "$git_branch"
            set git_branch (command git rev-parse --short HEAD 2>/dev/null)
        end
    end

    echo -n " "

    if test -n "$git_branch"
        set_color dbbc7f
        echo -n " $git_branch "
    end

    if test "$gen_count" -gt 0
        set_color -i brblack
        echo -n "$gen_count "
    end

    if string match -q "/nix/store*" "$real_pwd"
        set_color d3869b
    else if test "$nixos_changed" -eq 1
        set_color red
    else if set -q IN_NIX_SHELL
        set_color blue
    else if test "$PWD" != "/etc/nixos"; and test -e flake.nix
        set_color e69875
    else if test "$nixos_ahead" -eq 1
        set_color green
    else
        if test "$USER" = "root"
            set_color 9d0006
        else
            set_color white
        end
    end

    echo -n " "

    set_color normal
end

function flake
    set -l is_new_git 0
    if not command git rev-parse --is-inside-work-tree >/dev/null 2>&1
        command git init -b main 2>/dev/null
        set is_new_git 1
    end

    echo '{
inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
outputs = {
self,
nixpkgs,
}: {
devShells.x86_64-linux.default = let
pkgs = nixpkgs.legacyPackages.x86_64-linux;
in
pkgs.mkShell {
  packages = with pkgs; [
  #
  ];
};
};
}' > flake.nix

    command git add flake.nix 2>/dev/null

    echo "use flake" > .envrc
    command mkdir -p .git/info 2>/dev/null
    if not command grep -q "^\.envrc\$" .git/info/exclude 2>/dev/null
        echo ".envrc" >> .git/info/exclude
    end

    direnv allow

    if test -f flake.lock
        command git add flake.lock 2>/dev/null
    end

    if test "$is_new_git" -eq 1
        command git commit -m "init: nix flake environment" --no-verify >/dev/null 2>&1
        echo "Git repository initialized with 'main' branch."
    else
        echo "Added files to existing Git repository."
    end

    echo "Flake and direnv successfully initialized."
end

function unflake
    if type -q direnv
        command direnv block 2>/dev/null
    end

    rm -rf .direnv/ flake.lock flake.nix .envrc

    if test -d .git
        command git reset HEAD -- . 2>/dev/null
        if test (command git log --oneline 2>/dev/null | count) -eq 1
            rm -rf .git
            echo "Removed temporary Git repository."
        end
    end

    set -e IN_NIX_SHELL
    command direnv reload 2>/dev/null
    command kill -s WINCH (pgrep -P $fish_pid -x direnv 2>/dev/null; or echo $fish_pid) 2>/dev/null

    echo "Flake environment completely unloaded."
end
 
 
function fid
  if not type -q rg
      echo "Error: ripgrep (rg) not installed!"
      return 1
  end
  fzf --ansi --disabled --query "$argv" \
    --delimiter : \
    --bind "change:reload:rg --column --line-number --no-heading --color=always --smart-case {q} || true" \
    --preview "bat --color=always --style=numbers --highlight-line {2} {1} 2>/dev/null"
end 
 
function dif
  if not set -q argv[1]
      echo "Usage: dixg <old_generation_index> [new_generation_index]"
      echo "Example: dixg 42 43  (compare 42 and 43)"
      echo "         dixg 42     (compare 42 with current generation)"
      return 1
  end

  set -l old_path "/nix/var/nix/profiles/system-$argv[1]-link"
  set -l new_path "/run/current-system"

  if set -q argv[2]
      set new_path "/nix/var/nix/profiles/system-$argv[2]-link"
  end

  if not test -e $old_path
      echo "Error: Generation $argv[1] not found ($old_path)"
      return 1
  end

  if test "$new_path" != "/run/current-system"; and not test -e $new_path
      echo "Error: Generation $argv[2] not found ($new_path)"
      return 1
  end

  dix $old_path $new_path
end

function system-age-info
    set -l install_time 0
    
    if test -d /etc/nixos
        set install_time (stat -c %Y /etc/nixos 2>/dev/null)
    else
        set install_time (stat -c %W / 2>/dev/null)
    end

    if test -z "$install_time" -o "$install_time" = "0"
        if test -d /lost+found
            set install_time (stat -c %Y /lost+found 2>/dev/null)
        else
            set install_time (stat -c %Y / 2>/dev/null)
        end
    end

    set -l now (date +%s)
    set -l secs (math "$now - $install_time")

    if test "$secs" -lt 0
        set secs 0
    end
    set -l mins (math -s0 "$secs / 60")
    set -l hours (math -s0 "$secs / 3600")
    set -l days (math -s0 "$secs / 86400")
    set -l months (math -s0 "$secs / 2592000")
    set -l years (math -s0 "$secs / 31536000")
    set -l g (set_color green)
    set -l n (set_color normal)
    echo "In $g""Seconds:$n $secs"
    echo "In $g""Minutes:$n $mins"
    echo "In $g""Hours:$n $hours"
    echo "In $g""Days:$n $days"
    echo "In $g""Months:$n $months"
    echo "In $g""Years:$n $years"
end

function formate
    set target (test -n "$argv[1]"; and echo $argv[1]; or echo ".")
    find $target -name "*.nix" -exec alejandra {} \; 2> /dev/null
end

function l
    lsd -l
end

function ll
    lsd -alh
end

function ls
    lsd
end

if status is-login
    set -gx PATH /usr/local/bin /usr/bin /bin /usr/local/sbin /usr/sbin /sbin $PATH
end

function nxs
    set -gx NXS_ORIGIN_DIR $PWD
    
    set -l clean_args
    for arg in $argv
        set -a clean_args (string replace "nixpkgs#" "" $arg)
    end

    if test (count $clean_args) -gt 0
        set -l expression "let base = (import /etc/nixos/shell.nix {}); in base.overrideAttrs (old: { buildInputs = old.buildInputs ++ (with import <nixpkgs> {}; [$clean_args]); })"
        nix-shell -E "$expression" --run "cd $NXS_ORIGIN_DIR; fish -l"
    else
        nix-shell /etc/nixos/shell.nix --run "cd $NXS_ORIGIN_DIR; fish -l"
    end
end

function e
    set -gx NXS_ORIGIN_DIR $PWD
    set -l shell_path "/home/mark/heh/shell.nix"
    
    set -l clean_args
    for arg in $argv
        set -a clean_args (string replace "nixpkgs#" "" $arg)
    end

    if test (count $clean_args) -gt 0
        set -l expression "let base = (import $shell_path {}); in base.overrideAttrs (old: { buildInputs = old.buildInputs ++ (with import <nixpkgs> {}; [$clean_args]); })"
        nix-shell -E "$expression" --run "cd $NXS_ORIGIN_DIR; fish -l"
    else
        nix-shell $shell_path --run "cd $NXS_ORIGIN_DIR; fish -l"
    end
end

function nix
    if not contains -- "$argv[1]" "run" "shell"
        command nix $argv
        return
    end
    set -lx XDG_CONFIG_HOME "/tmp/nix_xdg_$fish_pid/config"
    set -lx XDG_DATA_HOME   "/tmp/nix_xdg_$fish_pid/data"
    set -lx XDG_CACHE_HOME  "/tmp/nix_xdg_$fish_pid/cache"
    mkdir -p $XDG_CONFIG_HOME $XDG_DATA_HOME $XDG_CACHE_HOME
    if test "$argv[1]" = "run"
        if string match -q "*#*" -- "$argv[2]"
            command nix $argv
        else
            set -l new_args "run" "--impure" "nixpkgs#$argv[2]" $argv[3..-1]
            command nix $new_args
        end
    else
        command nix $argv
    end
end

if type -q zoxide
    zoxide init fish --cmd cd | source
end

function s 
  yazi
end

function ss
    set -l list_cmd "fd --type f --hidden --no-follow --one-file-system \
        --exclude .git \
        --exclude '/run/media/*' \
        --exclude '/mnt/*' \
        --strip-cwd-prefix"

    set -l last_query ""
    while true
        set -l fzf_output (eval $list_cmd | fzf --header " [Ctrl-G] Toggle | [Enter] Open | [Ctrl-S] Subl | [Ctrl-E] pcmanfm-qt | [ESC] Close " \
            --preview-window=right:35%:border-left:follow \
            --prompt "Files> " \
            --query "$last_query" \
            --expect="ctrl-s,ctrl-e,enter" \
            --print-query \
            --bind "resize:refresh-preview" \
            --bind "ctrl-g:transform:[ \"\$FZF_PROMPT\" = 'Files> ' ] && echo 'reload(zoxide query -l)+change-prompt(Zoxide> )' || echo \"reload($list_cmd)+change-prompt(Files> )\"" \
            --bind 'ctrl-backspace:backward-kill-word' \
            --bind 'ctrl-w:backward-kill-word' \
            --bind 'ctrl-u:unix-line-discard' \
            --preview '
                kitty +kitten icat --clear --stdin no --silent --transfer-mode file </dev/null >/dev/tty
                printf "\033[2J\033[H"
                if test -d {}
                    lsd --tree --depth 2 --color=always {} 2>/dev/null || ls -R {} 2>/dev/null
                else
                    if string match -q "image/*" "$type"
                        kitty +kitten icat --silent --stdin no --transfer-mode file --place "$FZF_PREVIEW_COLUMNS"x"$FZF_PREVIEW_LINES"@"$FZF_PREVIEW_LEFT"x"$FZF_PREVIEW_TOP" {} >/dev/tty
                    else
                        bat --style=numbers --color=always --line-range :500 {} 2>/dev/null || cat {} 2>/dev/null
                    end
                end')

        if test (count $fzf_output) -lt 3
            break
        end

        set last_query $fzf_output[1]
        set -l key_pressed $fzf_output[2]
        set -l selection $fzf_output[3]

        if test -z "$selection"
            break
        end

        if test "$key_pressed" = "ctrl-e"
            if test -d "$selection"
                pcmanfm-qt "$selection" >/dev/null 2>&1 & disown
            else
                set -l parent_dir (dirname "$selection")
                pcmanfm-qt "$parent_dir" >/dev/null 2>&1 & disown
            end
        else if test "$key_pressed" = "ctrl-s"
            subl "$selection" >/dev/null 2>&1 & disown
        else if test -d "$selection"
            cd "$selection"
            set last_query ""
        else
            set -l ext (string lower (path extension "$selection" | string replace "." ""))
            set -l mime (file --mime-type -b "$selection")
            if test "$ext" = "exe"
                umu-run "$selection" >/dev/null 2>&1 & disown
            else if string match -q "image/*" "$mime"
                pinta "$selection" >/dev/null 2>&1 & disown
            else if string match -q "text/*" "$mime"; or string match -q "*json*" "$mime"; or string match -q "*javascript*" "$mime"; or string match -q "*sh*" "$mime"; or test -f "$selection"
                command micro "$selection" </dev/tty >/dev/tty
            else
                xdg-open "$selection" >/dev/null 2>&1 & disown
            end
        end
    end
end

function cat
    if test (count $argv) -eq 0
        command cat
        return
    end
    set -l target $argv[1]
    if not test -e "$target"
        echo "No such file..."
        return 1
    end
    set -l ext (string lower (path extension "$target" | string replace "." ""))
    if contains "$ext" jpeg jpg png webm
        kitty +kitten icat --align left "$target"
    else
        if type -q bat
            bat --style=numbers --color=always "$target"
        else
            command cat "$target"
        end
    end
end

if status is-interactive
    if set -q IN_NIX_SHELL
        clear
        echo "Active packages in nix-shell:"
        echo $PATH | tr ' ' '\n' | grep "/nix/store" | sed -E 's|/nix/store/[a-z0-9]+-(.*)/bin|\1|' | sort -u
    else
        if string match -q "/dev/tty*" (tty)
            clear
        else if type -q fastfetch
            clear
            fastfetch
        end
    end
end

function on_exit --on-event fish_exit
    if set -q IN_NIX_SHELL
        if set -q NXS_ORIGIN_DIR
            cd $NXS_ORIGIN_DIR
            set -e NXS_ORIGIN_DIR
        end
        clear
        echo -e "\n\e[31mexited shell\e[0m"
        echo
    end
end

function clip_archive
    set -l raw_paths (wl-paste 2>/dev/null | string trim | string split \n)
    if test -z "$raw_paths"
        set raw_paths (wl-paste -t UTF8_STRING 2>/dev/null | string trim | string split \n)
    end
    if test -z "$raw_paths"
        notify-send "error: no files in clipboard" -u critical
        return 1
    end
    set -l clean_paths
    for p in $raw_paths
        set -a clean_paths (string replace -r '^file://' '' -- "$p" | string replace -r '^[\'"]|[\'"]$' '')
    end
    if not test -e "$clean_paths[1]"
        notify-send "error: file not found UwU" -u critical
        return 1
    end
    if test (count $clean_paths) -eq 1; and string match -r '\.(zip|tar|gz|bz2|xz|7z|rar)$' "$clean_paths[1]"
        set -l file_path $clean_paths[1]
        set -l dir_path (dirname "$file_path")
        set -l filename (basename "$file_path")
        notify-send "decompressing..."
        if type -q ouch
            pushd "$dir_path"
            ouch decompress "$filename"
            popd
        else
            set -l out_dir (string replace -r '\.[^.]+$' '' -- "$file_path")
            mkdir -p "$out_dir"
            if string match -q "*.zip" "$filename"
                unzip "$file_path" -d "$out_dir"
            else
                tar -xf "$file_path" -C "$out_dir"
            end
        end
        notify-send "Ready at $dir_path!"
    else
        notify-send "archiving (multiple files)..."
        set -l base_dir (dirname "$clean_paths[1]")
        set -l base_name (basename "$clean_paths[1]")
        set -l output_file "$base_dir/$base_name.tar.xz"
        if type -q ouch
            ouch compress $clean_paths "$output_file"
        else
            pushd "$base_dir"
            set -l relative_paths
            for p in $clean_paths
                set -a relative_paths (basename "$p")
            end
            tar -cJf "$output_file" $relative_paths
            popd
        end
        notify-send "Archive created: $base_name.tar.xz ~~"
    end
end

function na
    pcmanfm-qt (pwd) >/dev/null 2>&1 & disown
end

function fgrep
    set -l path $argv[1]
    set -l mode $argv[2]
    set -l query $argv[3]
    if test $mode = "1"
        find $path -type f -iname "*$query*"
    else if test $mode = "2"
        grep -rnIi $path -e "$query"
    else
        echo "1 (search file) 2 (search text)"
    end
end

fish_add_path ~/heh
fish_add_path /usr/bin
