init_pproject() {
    if [[ $# -ne 1 ]]; then
        echo "Usage: init_python_project <project_name>"
        return 1
    fi

    project_name=$1
    env_name="${project_name}_env"

    mkdir "$project_name" && cd "$project_name" || {
        echo "Failed to create or enter the project directory."
        return 1
    }

    #git init
    python3 -m venv "$env_name"
    echo "Virtual environment '${env_name}' created."

    # Optional: Create a basic project structure
    mkdir "src"
    echo "Project directories created."

    # Optional: Create a .gitignore file with common Python ignores
    echo -e "*.pyc\n__pycache__/\n${env_name}/" > .gitignore
    echo -e "*.env" > .gitignore
    echo ".gitignore with Python standards created."

    # Optional: Activate the environment and install essential packages
    source "${env_name}/bin/activate"
    pip install --upgrade pip
    echo "Environment activated and essential packages installed."

}