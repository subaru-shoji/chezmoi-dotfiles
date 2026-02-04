function suspend-enable --description "Enable suspend"
    if test (uname) = "Darwin"
        sudo pmset -b sleep 5
        sudo pmset -b disablesleep 0
    else if test (uname) = "Linux"
        sudo systemctl unmask sleep.target suspend.target hibernate.target hybrid-sleep.target
    end
    echo "Suspend enabled"
end
