import os
import time
from master.server import Sender
from master.server_thread import ThreadedListener


def title_bar():
    print("\t**********************************************")
    print("\t**************   Communicator   **************")
    print("\t**********************************************")


def user_choice():
    print("\n[1] Send broadcast message")
    print("[q] Quit.")
    return input("What would you like to do? ")


if __name__ == '__main__':
    title_bar()

    s = ThreadedListener()
    s.start()
    s.start_listen()

    sender = Sender()
    sender.set_broadcast_ip()
    choice = ''
    while choice != 'q':
        message = str(input("Message to send: ")).encode("utf-8")
        sender.send_broadcast_message(message)
        time.sleep(1)
        input("Press q to quit or other to continue ")

