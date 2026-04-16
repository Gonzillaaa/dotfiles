import random
import string

def generate_usernames(num_usernames, prefix='0x', length=6):
    """Generate a list of usernames with a specified prefix and random characters."""
    usernames = []
    for _ in range(num_usernames):
        random_chars = ''.join(random.choices(string.ascii_letters + string.digits, k=length))
        username = f'{prefix}{random_chars}'.lower()  # Convert to lowercase
        usernames.append(username)
    return usernames

def main():
    # Prompt the user for the number of usernames
    try:
        num_usernames = int(input("Enter the number of usernames to generate: "))
    except ValueError:
        print("Please enter a valid integer.")
        return

    # Generate the usernames
    usernames = generate_usernames(num_usernames)

    # Print the usernames
    print("\nGenerated Usernames:")
    for username in usernames:
        print(username)

if __name__ == "__main__":
    main()