function fzf_file_select --description 'Select files with fzf, output relative paths to clipboard'
    # Get current path from argument (passed from tmux)
    set -l start_dir $argv[1]
    if test -z "$start_dir"
        set start_dir (pwd)
    end

    cd $start_dir

    # Inside git repo - move to git root for relative paths
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1
        cd (git rev-parse --show-toplevel)
    end

    # List files with relative paths and select with fzf
    set -l selected (rg --files 2>/dev/null | \
        fzf -m \
        --preview 'bat --color=always --line-range :100 {}' \
        --bind 'ctrl-a:select-all,ctrl-d:deselect-all')

    if test (count $selected) -gt 0
        # Join with newlines and copy to clipboard
        string join \n $selected | pbcopy
    end
end
