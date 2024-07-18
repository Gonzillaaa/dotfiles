import random

def load_word_list(filename):
    """Load words from a given filename into a list."""
    with open(filename, 'r') as file:
        words = [line.strip() for line in file.readlines()]
    return words

def generate_passkeys(num_passkeys, num_words=3, separator='-'):
    """Generate passkeys composed of random words."""
    word_list = load_word_list('english.txt')  # Specify the path to your word list file
    passkeys = []

    for _ in range(num_passkeys):
        selected_words = random.choices(word_list, k=num_words)
        passkey = separator.join(selected_words)
        passkeys.append(passkey)

    return passkeys

def main():
    num_passkeys = int(input("Enter the number of passkeys to generate: "))
    num_words = int(input("Enter the number of words per passkey: "))
    passkeys = generate_passkeys(num_passkeys, num_words)

    print("\nGenerated Passkeys:")
    for passkey in passkeys:
        print(passkey)

if __name__ == "__main__":
    main()

