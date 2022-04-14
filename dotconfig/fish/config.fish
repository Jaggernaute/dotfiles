function jaggifetch
    if status is-interactive
        neofetch --backend kitty --xoffset 5 --image_size 400px --crop_mode none --source ~/Pictures/pp/jaggi_pfp.png
    end
end


function fish_greeting
    if status is-interactive
        jaggifetch
    end
end
