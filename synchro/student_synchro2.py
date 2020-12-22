#!/usr/bin/env python3
import socket


class student_send:
    def __init__(self):
        self.student_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.connected = False
        self.ip = '127.0.0.1'
        self.port = 8889

    def connect(self):
        while not self.connected:
            try:
                self.student_socket.connect((self.ip, self.port))
                self.connected = True
            except ConnectionRefusedError:
                self.connected = False

    def send(self):
        # TBD
        self.student_socket.send(bytes('{"do": "something"}', 'UTF-8'))
        print("send message")


if __name__ == '__main__':
    s = student_send()
    s.connect()
    s.send()
