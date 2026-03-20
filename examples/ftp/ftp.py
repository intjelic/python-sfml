from sfml import network as sf_network


def decode_bytes(value):
    if isinstance(value, bytes):
        return value.decode("utf-8", errors="replace")
    return str(value)


def print_response(response):
    print(f"Status: {response.status}")
    print(decode_bytes(response.message).strip())


def main():
    address_text = input("Enter the FTP server address: ").strip()
    address = sf_network.IpAddress.from_string(address_text)
    server = sf_network.Ftp()
    connected = False

    try:
        response = server.connect(address)
        print_response(response)
        if not response.ok:
            return

        connected = True
        user = input("User name: ").strip()
        password = input("Password: ").strip()

        response = server.login(user, password)
        print_response(response)
        if not response.ok:
            return

        while True:
            print("=" * 59)
            print("Choose an action:")
            print("1. Print working directory")
            print("2. Print contents of working directory")
            print("3. Change directory")
            print("4. Create directory")
            print("5. Delete directory")
            print("6. Rename file")
            print("7. Remove file")
            print("8. Download file")
            print("9. Upload file")
            print("10. Upload file and append")
            print("11. Send raw FTP command")
            print("0. Disconnect")

            try:
                choice = int(input("Your choice: ").strip())
            except ValueError:
                print("Invalid choice.")
                continue

            if choice == 1:
                response = server.get_working_directory()
                print_response(response)
                if response.ok:
                    print(f"Current directory: {decode_bytes(response.get_directory())}")
            elif choice == 2:
                response = server.get_directory_listing()
                print_response(response)
                if response.ok:
                    for filename in response.filenames:
                        print(decode_bytes(filename))
            elif choice == 3:
                directory = input("Choose a directory: ").strip()
                print_response(server.change_directory(directory))
            elif choice == 4:
                directory = input("Name of the directory to create: ").strip()
                print_response(server.create_directory(directory))
            elif choice == 5:
                directory = input("Name of the directory to remove: ").strip()
                print_response(server.delete_directory(directory))
            elif choice == 6:
                source = input("Name of the file to rename: ").strip()
                destination = input("New name: ").strip()
                print_response(server.rename_file(source, destination))
            elif choice == 7:
                filename = input("Name of the file to remove: ").strip()
                print_response(server.delete_file(filename))
            elif choice == 8:
                filename = input("Filename to download: ").strip()
                directory = input("Local destination directory: ").strip() or "."
                print_response(server.download(filename, directory))
            elif choice == 9:
                filename = input("Local file to upload: ").strip()
                directory = input("Remote destination directory: ").strip()
                print_response(server.upload(filename, directory))
            elif choice == 10:
                filename = input("Local file to upload: ").strip()
                directory = input("Remote destination directory: ").strip()
                print_response(server.upload(filename, directory, sf_network.Ftp.BINARY, append=True))
            elif choice == 11:
                command = input("FTP command: ").strip().upper()
                parameter = input("Optional parameter: ").strip()
                print_response(server.send_command(command, parameter))
            elif choice == 0:
                break
            else:
                print("Invalid choice.")
    finally:
        if connected:
            print("Disconnecting from server...")
            server.disconnect()


if __name__ == "__main__":
    main()
