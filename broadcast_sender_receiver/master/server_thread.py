import socket
from datetime import date
import threading
import sys
import time
import trace


def listen():
    listener = socket.socket(socket.AF_INET, socket.SOCK_DGRAM, socket.IPPROTO_UDP)
    listener.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    listener.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
    listener.settimeout(1)
    listener.bind(("", 37021))
    while True:
        try:
            message, addr = listener.recvfrom(4096)
            print("Presence reported: ", message.decode("utf-8"))
            f = open("presence" + str(date.today()) + ".txt ", "a")
            f.write(message.decode("utf-8") + " - " + str(addr) + "\n")
            f.close()
        except socket.timeout:
            None


class ThreadedListener(threading.Thread):
    def __init__(self, *args, **keywords):
        threading.Thread.__init__(self, *args, **keywords)
        self.killed = False

    def start(self):
        self.__run_backup = self.run
        self.run = self.__run
        threading.Thread.start(self)

    def __run(self):
        sys.settrace(self.globaltrace)
        self.__run_backup()
        self.run = self.__run_backup

    def globaltrace(self, frame, event, arg):
        if event == 'call':
            return self.localtrace
        else:
            return None

    def localtrace(self, frame, event, arg):
        if self.killed:
            if event == 'line':
                raise SystemExit()
        return self.localtrace

    def kill(self):
        self.killed = True


if __name__ == '__main__':
    s = ThreadedListener()
    s.start()
    s.kill()
    s.join()
