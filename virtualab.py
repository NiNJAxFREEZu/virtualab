import sys
import os
import json
import vagrantfileparser as vfp
import platform
import time
import argparse

def print_manpage():
    with open("manpage", 'r') as manpage_file:
        manpage = manpage_file.read()

    print(manpage)


def start_class(config_json):
    pvmname = vfp.parse(config_json)
    if platform.system() == 'Windows':
        os.system('dos2unix */*.sh')
        os.system('dos2unix */*/*.sh')
        os.system('dos2unix data/executables/*.c')
        os.system('dos2unix data/executables/*.py')

    os.system("vagrant up")
    os.system("vagrant ssh " + pvmname + " --command \"/home/vagrant/data/executables/./finalize.sh\"")
    print("VirtuaLab instance is now running!")

def stop_class():
    os.system("vagrant destroy --force")


if __name__ == "__main__":
    # Adding command line arguments
    # parser = argparse.ArgumentParser()

    #parser.add_argument('name', help='name of user')
    #parser.add_argument('-g', '--greeting', default='Hello', help='optional alternate greeting')

    #args = parser.parse_args()

    #print("{greeting}, {name}!".format(greeting=args.greeting,name=args.name))

    # Interpreting command line arguments
    start = time.time()
    if sys.argv[1] == "help":
        print_manpage()

    elif sys.argv[1] == "start":
        with open(sys.argv[2], 'r') as file:
            class_config_json_raw = file.read()

        try:
            class_config_json = json.loads(class_config_json_raw)
        except ValueError as e:
            sys.stderr.write(sys.argv[2] + " does not contain a valid JSON file.\n")
            exit(1)

        start_class(class_config_json)
        end = time.time()
        sys.stdout.write("Time elapsed (in seconds): " + str((end - start)))

    elif sys.argv[1] == "stop":
        stop_class()

    else:
        sys.stderr.write("\'" + sys.argv[1] + "\' is not a valid virtualab command. See \'virtualab help.\'\n")
        exit(1)
