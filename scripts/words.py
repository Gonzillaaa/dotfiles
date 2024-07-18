def file_to_list(filename):
    """Reads a file with one word per line and converts it into a Python list."""
    try:
        with open(filename, 'r') as file:
            word_list = [line.strip() for line in file]
        return word_list
    except FileNotFoundError:
        print(f"The file '{filename}' was not found.")
        return []

       
def main():

    # Convert the file contents to a list
    word_list = file_to_list("english.txt")

    if word_list:
        print("\nPython List:")
        print(word_list)
    
    print(len(word_list))
    
    

if __name__ == "__main__":
    main()
