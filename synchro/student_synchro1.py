#!/usr/bin/env python3
import socket
import json


class student_listen:
    def __init__(self):
        self.student_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.connected = False
        self.got_message = False
        self.ip = '127.0.0.1'
        self.port = 8888
       
    def connect(self):
        while not self.connected:
            try:
                self.student_socket.connect((self.ip, self.port))
                self.connected = True
            except ConnectionRefusedError:
                self.connected = False

    def listen(self):
        while not self.got_message:
            data = self.student_socket.recv(1024)
            message = json.loads(data)
            print(message)
            with open("my_turn.txt", "w") as f:
                f.write("i got message")
            self.got_message = True


if __name__ == '__main__':
    s = student_listen()
    s.connect()
    s.listen()
