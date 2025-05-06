# ----------------------------------------------------------
# A tiny, stylish dispatcher that lets you:
#   g → jump to a ghq project (using fzf for fuzzy search)
#   c → switch to a git branch  (also with fzf)
# Built with Charmbracelet’s “gum” for the UI ✨
# ----------------------------------------------------------

function __which-key
    # Show a slick two‑line menu
    # 1. Display a chic two‑line menu
    gum style \
      --border rounded --margin "1 1" --padding "1 2" --align left \
      --bold "g → ghq project" "c → git checkout" "z → zoxide"

    # 2. Show a small hint below the box
    # gum style --foreground 250 --italic "Press 'g' or 'c' — no Enter needed"

    # 3. Grab a single keystroke (immediate return)
    read --nchars 1 choice

    switch $choice
        case g
            # Pick a repo from ghq, then cd into it
            cd (ghq list | fzf | xargs -I {} echo $HOME/Projects/{})
        case c
            # Pick a branch and check it out
            gc
        case z
            zi
        case '*'
            gum style --foreground 196 --bold "⚠️  Unknown choice: $choice"
    end
end

bind --mode insert \cg '__which-key; echo; commandline -f repaint'
