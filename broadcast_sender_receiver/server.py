import socket
import time


class Sender:
    def __init__(self):
        self.server = socket.socket(socket.AF_INET, socket.SOCK_DGRAM, socket.IPPROTO_UDP)
        self.server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        self.server.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)

        self.ip_broadcast = input("Enter the ip address for broadcast: ")


if __name__ == '__main__':
    sender = Sender()
    while True:
        message = str(input("Message to send: ")).encode("utf-8")
        sender.server.sendto(message, (sender.ip_broadcast, 37020))
        print("message sent!")
        time.sleep(1)
