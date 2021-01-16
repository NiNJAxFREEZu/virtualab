import sys
import os
import json
import vagrantfileparser as vfp
import platform


def print_manpage():
    with open("manpage", 'r') as manpage_file:
        manpage = manpage_file.read()

    print(manpage)

def start_class(config_json):
    pvmname = vfp.parse(config_json)
    if platform.system() == 'Windows':
        os.system('dos2unix */*.sh')
        os.system('dos2unix data/*.c')
        os.system('dos2unix data/*.py')

    os.system("vagrant up")
    os.system("vagrant ssh " + pvmname + " --command \"/home/vagrant/data/executables/./finalize.sh\"")
    print("VirtuaLab instance is now running!")

if __name__ == "__main__":
    # Interpreting command line arguments

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

    elif sys.argv[1] == "stop":
        os.system("vagrant destroy -f")

    else:
        sys.stderr.write("\'" + sys.argv[1] + "\' is not a valid virtualab command. See \'virtualab help.\'\n")
        exit(1)
