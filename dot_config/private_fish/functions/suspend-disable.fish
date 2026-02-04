function suspend-disable --description "Disable suspend"
    if test (uname) = "Darwin"
        sudo pmset -b sleep 0
        sudo pmset -b disablesleep 1
    else if test (uname) = "Linux"
        sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
    end
    echo "Suspend disabled"
end
