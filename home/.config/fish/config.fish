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

# "For Each Subdirectory Do" Function
function fesd
    set -l verbose 0
    if test (count $argv) -eq 0
        echo "Usage: fesd [-v] <command>"
        echo "Executes the specified command in each subdirectory of the current directory."
        return 1
    end
    if test "$argv[1]" = "-v"
        set verbose 1
        set argv $argv[2..-1]
    end
    for dir in (find . -maxdepth 1 -type d)
        if test "$dir" != "."
            if test $verbose -eq 1
                echo "$dir:"
            end
            pushd $dir
            # Execute the command passed to the function
            if test (count $argv) -gt 0
                eval $argv
            end
            popd
        end
    end
end
