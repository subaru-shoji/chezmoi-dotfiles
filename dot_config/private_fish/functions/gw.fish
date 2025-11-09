function gw --description 'Create git worktree in ../repo.worktree/branch'
    if test (count $argv) -eq 0
        echo "Usage: gw <branch-name>"
        return 1
    end

    set branch_name $argv[1]

    # Get git root directory
    set git_root (git rev-parse --show-toplevel)
    if test $status -ne 0
        echo "Error: Not in a git repository"
        return 1
    end

    # Get repository name (git root directory name)
    set repo_name (basename $git_root)

    # Sanitize branch name for use in directory path
    # Replace characters that are invalid in filenames
    set safe_branch_name (string replace -a / _ $branch_name)
    set safe_branch_name (string replace -a : _ $safe_branch_name)
    set safe_branch_name (string replace -a \\ _ $safe_branch_name)
    set safe_branch_name (string replace -a '*' _ $safe_branch_name)
    set safe_branch_name (string replace -a '?' _ $safe_branch_name)
    set safe_branch_name (string replace -a '"' _ $safe_branch_name)
    set safe_branch_name (string replace -a '<' _ $safe_branch_name)
    set safe_branch_name (string replace -a '>' _ $safe_branch_name)
    set safe_branch_name (string replace -a '|' _ $safe_branch_name)

    # Construct worktree path
    set worktree_path "$git_root/../$repo_name.worktree/$safe_branch_name"

    # Create worktree with new branch
    git worktree add -b $branch_name $worktree_path
    and cd $worktree_path
end
