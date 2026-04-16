import random
import string

def generate_passkeys(num_passkeys, length=12):
    """Generate a list of passkeys using a mix of characters for increased security."""
    # Define the character pool including uppercase, lowercase, digits, and special characters
    char_pool = string.ascii_letters + string.digits + "!@#$%^&*()"

    passkeys = []
    for _ in range(num_passkeys):
        # Generate a passkey from the pool
        passkey = ''.join(random.choices(char_pool, k=length))
        passkeys.append(passkey)
    return passkeys

def main():
    # Prompt the user for the number of passkeys
    try:
        num_passkeys = int(input("Enter the number of passkeys to generate: "))
    except ValueError:
        print("Please enter a valid integer.")
        return

    # Generate the passkeys
    passkeys = generate_passkeys(num_passkeys)

    # Print the passkeys
    print("\nGenerated Passkeys:")
    for passkey in passkeys:
        print(passkey)

if __name__ == "__main__":
    main()

