function ytsong --wraps='yt-dlp -f "bestaudio[ext=m4a]/bestaudio/best"' --wraps='yt-dlp -f "bestaudio[ext=mp3]/bestaudio/best"' --wraps='yt-dlp -x --audio-format mp3 --audio-quality 0' --wraps='yt-dlp -x --audio-format mp3 --audio-quality 0 --add-metadata --embed-thumbnail' --description 'alias ytsong=yt-dlp -x --audio-format mp3 --audio-quality 0 --add-metadata --embed-thumbnail'
    yt-dlp -x --audio-format mp3 --audio-quality 0 --add-metadata --embed-thumbnail $argv
end
