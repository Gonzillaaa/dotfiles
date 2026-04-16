import random
import string

def generate_passwords(num_passwords=5, length=8):
    """Generate a list of passwords using lowercase letters and numbers."""
    passwords = []
    for _ in range(num_passwords):
        # Generate password using lowercase letters and digits
        password = ''.join(random.choices(string.ascii_lowercase + string.digits, k=length))
        passwords.append(password)
    return passwords

def main():
    # Ask the user for the number of passwords and their length
    num_passwords = int(input("Enter the number of passwords to generate: "))
    length = int(input("Enter the length of each password: "))

    # Generate the passwords
    passwords = generate_passwords(num_passwords, length)

    # Print the generated passwords
    print("\nGenerated Passwords:")
    for password in passwords:
        print(password)

if __name__ == "__main__":
    main()
