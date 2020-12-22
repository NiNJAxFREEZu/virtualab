#!/usr/bin/env python3
import socket
import sys
import threading
import json

TCP_IP_SEND = ''
TCP_PORT_SEND = 8888
TCP_IP_LISTEN = ''
TCP_PORT_LISTEN = 8889
BUFFER_SIZE = 1024
clientCount = 0


class professor:
    def __init__(self):
        self.number_of_students = 1

    def send_sync(self):
        global clientCount
        try:
            send_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            send_socket.bind((TCP_IP_SEND, TCP_PORT_SEND))
            send_socket.listen(self.number_of_students)
            while clientCount < self.number_of_students:
                client_socket, addr = send_socket.accept()
                print('Connected with ' + addr[0] + ':' + str(addr[1]))
                clientCount = clientCount + 1
                print("Client count: ", clientCount)
                client_socket.send(bytes('{"do": "something"}', 'UTF-8'))
            send_socket.close()
        except socket.error:
            print('Could not start professor')
            sys.exit()

    def listen_sync(self):
        global clientCount
        listen_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        listen_socket.bind((TCP_IP_LISTEN, TCP_PORT_LISTEN))
        listen_socket.listen(self.number_of_students)
        while clientCount < self.number_of_students:
            client_socket, addr = listen_socket.accept()
            print('Connected with ' + addr[0] + ':' + str(addr[1]))
            clientCount = clientCount + 1
            print("Client count: ", clientCount)
            data = client_socket.recv(1024)
            print(json.loads(data))
            # TBD
        listen_socket.close()


if __name__ == '__main__':
    # First phase
    print("#"*20)
    print("Sending messages to students")
    s = professor()
    t1 = threading.Thread(target=s.send_sync)
    t1.start()
    t1.join()
    print("All students got message")

    # Second phase
    print("#" * 20)
    print("Listening for messages from students")
    clientCount = 0
    t2 = threading.Thread(target=s.listen_sync)
    t2.start()
    t2.join()
    print("Got message from all students")
    with open("how_many_ready.txt", "w") as f:
        f.write(str(clientCount))
