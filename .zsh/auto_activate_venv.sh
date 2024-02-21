# Function to automatically activate virtual environment based on directory name
auto_activate_venv() {
    # Check if a virtual environment directory exists with the current directory name plus "_env"
    if [[ -d "./${PWD##*/}_env" ]]; then
        # If the directory exists, activate the virtual environment
        source "./${PWD##*/}_env/bin/activate"
        echo "Activated virtual environment: ${PWD##*/}_env"
    # If no appropriate virtual environment is found and one is currently active, deactivate it
    elif [[ "$VIRTUAL_ENV" != "" ]]; then
        deactivate
    fi
}

# Use Zsh's chpwd hook to run the function every time the current directory changes
add-zsh-hook chpwd auto_activate_venv
