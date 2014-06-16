import os
import sfml.network as sf

# python 2.* compatability
try: input = raw_input
except NameError: pass

# choose the server address
address = input("Enter the FTP server address: ")
address = sf.IpAddress.from_string(address)

# create the server object which with you will communicate
server = sf.Ftp()

# connect to the server
response = server.connect(address)
print(response)
if not response.ok: exit()

# ask for user name and password
user = input("User name: ")
password = input("Password: ")

# login to the server
response = server.login(user, password)
print(response)
if not response.ok: exit()

# main menu
choice = 0
while True:
    print("===========================================================")
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
    print("0. Disconnect\n\n")

    choice = int(input("Your choice: "))

    os.system('clear')

    if choice == 1:
        # print the current server directory
        response = server.get_working_directory()
        print(response)
        print("Current directory is {0}".format(response.get_directory()))
    elif choice == 2:
        # print the contents of the current server directory
        response = server.get_directory_listing()
        print(response)
        for filename in response.filenames:
            print(filename)
    elif choice == 3:
        # change the current directory
        directory = input("Choose a directory: ")
        response = server.change_directory(directory)
        print(response)
    elif choice == 4:
        # create a new directory
        directory = input("Name of the directory to create: ")
        response = server.create_directory(directory)
        print(response)
    elif choice == 5:
        # remove an existing directory
        directory = input("Name of the directory to remove: ")
        response = server.delete_directory(directory)
        print(response)
    elif choice == 6:
        # rename a file
        source = input("Name of the file to rename: ")
        destination = input("New name: ")
        response = server.rename_file(source, destination)
        print(response)
    elif choice == 7:
        # remove an existing directory
        filename = input("Name of the file to remove: ")
        response = server.delete_file(filename)
        print(response)
    elif choice == 8:
        # download a file from server
        filename = input("Filename of the file to download (relative to current directory): ")
        directory = input("Directory to download the file to: ")
        response = server.download(filename, directory)
        print(response)
    elif choice == 9:
        # upload a file to server
        filename = input("Path of the file to upload (absolute or relative to working directory): ")
        directory = input("Directory to upload the file to (relative to current directory): ")
        response = server.upload(filename, directory)
        print(response)
    elif choice == 0:
        break
    else:
        # wrong choice
        print("Invalid choice!")
        os.system('clear')

    if choice == 0:
        break

# disconnect from the server
print("Disconnecting from server...")
response = server.disconnect()

# wait until the user presses 'enter' key
input("Press enter to exit...")
