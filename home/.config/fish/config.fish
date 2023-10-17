#!/usr/bin/env fish
if status is-interactive
    
    set LS_OPTIONS "--color=always"

    if which lsd
        alias ls="lsd $LS_OPTIONS"
        alias ll="lsd $LS_OPTIONS -l"
        alias l="lsd $LS_OPTIONS -lA"
        alias lt="lsd $LS_OPTIONS --tree --depth"
    end
end