import socket
from datetime import date
import threading


class ThreadedListener(threading.Thread):
    def __init__(self):
        threading.Thread.__init__(self)
        self.listener = socket.socket(socket.AF_INET, socket.SOCK_DGRAM, socket.IPPROTO_UDP)
        self.listener.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        self.listener.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
        self.listener.bind(("", 37021))
        self.date = date.today()

    def listen(self):
        while True:
            message, addr = self.listener.recvfrom(4096)
            print("Presence reported: ", message.decode("utf-8"))
            f = open("presence"+str(self.date)+".txt", "a")
            f.write(message.decode("utf-8"))
            f.close()

    def start_listen(self):
        t = threading.Thread(target=self.listen)
        t.start()


if __name__ == '__main__':
    s = ThreadedListener()
    s.start()
    s.start_listen()
