import json

class VmObject:
    def __init__(self, hostname, ip, ssh_port, box):
        self.hostname = hostname.replace(' ', '')
        self.ip = ip
        self.ssh_port = ssh_port
        self.box = box

    def deparse(self) -> str:
        output = '\t{'
        output = output + '\t\t:hostname => ' + '\"' + self.hostname + '\",\n'
        output = output + '\t\t:ip => '       + '\"' + self.ip + '\",\n'
        output = output + '\t\t:ssh_port => ' + '\"' + str(self.ssh_port) + '\",\n'
        output = output + '\t\t:box => '      + '\"' + self.box + '\"\n'
        output = output + '\t}'

        return output

def parse(class_config_json):
    ipv4_subnet = "192.168.101"
    ipv4_last_octet = 2
    ssh_port = 2200

    # Create Vagrantfile header
    vfheader = 'Vagrant.configure(\"2\") do |config|\n'

    # Create Professors array
    professors = '\tprofessors=[\n'

    p = VmObject(
        hostname=class_config_json['professor']['name']
                 + class_config_json['professor']['surname'],
        ip=ipv4_subnet + '.' + str(ipv4_last_octet),
        ssh_port=ssh_port,
        box = class_config_json['vagrantbox'])
    professors = professors + p.deparse()
    ipv4_last_octet += 1
    ssh_port += 1

    professors = professors + '\t]\n'


    # Create Students array
    students = '\tstudents=[\n'

    for student in class_config_json['students']:
        s = VmObject(
            hostname=student['name'] + student['surname'] + student['albumnr'],
            ip=ipv4_subnet + '.' + str(ipv4_last_octet),
            ssh_port=ssh_port,
            box=class_config_json['vagrantbox'])
        students = students + s.deparse()
        ipv4_last_octet += 1
        ssh_port += 1

    students = students + '\t]\n'

    # Final step -> Write parsed vagrantfile into a file
    with open("VagrantfileFooter") as f:
        vffooter = f.read()

    output_file = open("Vagrantfile", "w")
    output_file.write(vfheader + professors + students + vffooter)
    output_file.close()
    return 1