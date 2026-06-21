function libreoffice --wraps='e nixpgks#libreoffice-qt6' --wraps='e nixpkgs#libreoffice-qt6' --description 'alias libreoffice=e nixpkgs#libreoffice-qt6'
    e nixpkgs#libreoffice-qt6 $argv
end
