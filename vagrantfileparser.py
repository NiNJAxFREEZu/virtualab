import json

class VmObject:
    def __init__(self, hostname, ip, ssh_port, box, lab):
        self.hostname = hostname.replace(' ', '')
        self.ip = ip
        self.ssh_port = ssh_port
        self.box = box
        self.lab = lab

    def deparse(self) -> str:
        output = '\t{'
        output = output + '\t\t:hostname => ' + '\"' + self.hostname + '\",\n'
        output = output + '\t\t:ip => '       + '\"' + self.ip + '\",\n'
        output = output + '\t\t:ssh_port => ' + '\"' + str(self.ssh_port) + '\",\n'
        output = output + '\t\t:box => '      + '\"' + self.box + '\",\n'
        output = output + '\t\t:lab => '      + '\"' + self.lab + '\"\n'
        output = output + '\t}'

        return output

def parse(class_config_json):
    ipv4_subnet = "192.168.101"
    ipv4_last_octet = 2
    ssh_port = 2200

    professor_ipv4 = ipv4_subnet + '.' + str(ipv4_last_octet)
    professor_hostname = 'p' + class_config_json['professor']['name'] + class_config_json['professor']['surname']
    # Create Vagrantfile header
    vfheader = 'Vagrant.configure(\"2\") do |config|\n'
    # Create Professors array
    professors = '\tprofessors=[\n'

    p = VmObject(
        hostname= professor_hostname,
        ip=professor_ipv4,
        ssh_port=ssh_port,
        box=class_config_json['vagrantbox'],
        lab=class_config_json['lab-config'])
    professors = professors + p.deparse()
    ipv4_last_octet += 1
    ssh_port += 1

    professors = professors + '\t]\n'

    # Creating professor's .virtualabinfo json
    pvirtualabinfo = json.loads(json.dumps(class_config_json['professor']))
    pvirtualabinfo['students'] = []
    # Create Students array
    students = '\tstudents=[\n'

    for student in class_config_json['students']:
        s = VmObject(
            hostname= 's' + student['albumnr'],
            ip=ipv4_subnet + '.' + str(ipv4_last_octet),
            ssh_port=ssh_port,
            box=class_config_json['vagrantbox'],
            lab=class_config_json['lab-config'])
        students = students + s.deparse()
        ipv4_last_octet += 1
        ssh_port += 1

        # Adding student info into professor .virtualabinfo
        student['ip'] = s.ip
        pvirtualabinfo['students'].append(student)

        # Saving student json into .virtualabinfo
        student['professorip'] = professor_ipv4
        output_file = open('data/' + s.hostname, 'w')
        output_file.write(str({'student': student}).replace('\'', '\"'))
        output_file.close()

    students = students + '\t]\n'

    # Creating professors .virtualabinfo
    pvirtualabinfo = {'professor': pvirtualabinfo}
    output_file = open('data/' + p.hostname, 'w')
    output_file.write(str(pvirtualabinfo).replace('\'', '\"'))
    output_file.close()

    # Final step -> Write parsed vagrantfile into a file
    with open("VagrantfileFooter") as f:
        vffooter = f.read()

    output_file = open("Vagrantfile", "w")
    output_file.write(vfheader + professors + students + vffooter)
    output_file.close()
    return professor_hostname