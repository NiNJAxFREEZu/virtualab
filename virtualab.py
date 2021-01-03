import sys
import json
import curses
import vagrantfileparser as vfp

def print_manpage():
    with open("manpage", 'r') as manpage_file:
        manpage = manpage_file.read()

    print(manpage)

def create_class_config():
    print("TODO")

def start_class(config_json):
    vfp.parse(config_json)

if __name__ == "__main__":
    # Interpreting command line arguments

    if sys.argv[1] == "help":
        print_manpage()

    elif sys.argv[1] == "create":
        create_class_config()

    elif sys.argv[1] == "start":
        with open(sys.argv[2], 'r') as file:
            class_config_json_raw = file.read()

        try:
            class_config_json = json.loads(class_config_json_raw)
        except ValueError as e:
            sys.stderr.write(sys.argv[2] + " does not contain a valid JSON file.\n")
            exit(1)

        start_class(class_config_json)

    else:
        sys.stderr.write("\'" + sys.argv[1] + "\' is not a valid virtualab command. See \'virtualab help.\'\n")
        exit(1)
