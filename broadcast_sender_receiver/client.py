import socket
import os
import logging


class Client:
    def __init__(self):
        self.logger = logging.getLogger('broadcast_app')
        handler = logging.FileHandler('broadcast_app.log')
        formatter = logging.Formatter('%(asctime)s %(levelname)s %(message)s')
        handler.setFormatter(formatter)
        self.logger.addHandler(handler)
        self.logger.setLevel(logging.INFO)

        self.client = socket.socket(socket.AF_INET, socket.SOCK_DGRAM, socket.IPPROTO_UDP)
        self.client.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        self.client.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)

    def start(self):
        self.client.bind(("", 37020))
        print(self.client.getsockname())
        print("Listening")


if __name__ == '__main__':
    student = Client()
    student.start()
    while True:
        data, addr = student.client.recvfrom(1024)
        data = data.decode("utf-8")
        print("received message: %s" % data)
        os.system("notify-send \"Message\" \"%s\"" % data)
        student.logger.info(data)



