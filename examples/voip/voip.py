import client
import server


PORT = 2435


def main():
    print("Do you want to be a server (s) or a client (c) ?")
    who = input().strip().lower()

    if who == 's':
        server.run_server(PORT)
    else:
        client.run_client(PORT)


if __name__ == "__main__":
    main()
