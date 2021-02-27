import json

class VmObject:
    def __init__(self, hostname, bridge, lab):
        self.hostname = hostname.replace(' ', '')
        self.bridge = bridge
        self.lab = lab

    def deparse(self) -> str:
        output = '\t{'
        output = output + '\t\t:hostname => ' + '\"' + self.hostname + '\",\n'
        output = output + '\t\t:bridge => ' + '\"' + self.bridge + '\",\n'
        output = output + '\t\t:lab => ' + '\"' + self.lab + '\"\n'
        output = output + '\t},'

        return output


def parse(class_config_json):
    vagrantbox = class_config_json['vagrantbox']
    professor_hostname = 'p' + class_config_json['professor']['name'] + class_config_json['professor']['surname']

    # Create Vagrantfile header
    vfheader = 'Vagrant.configure(\"2\") do |config|\nvagrantbox=\"' + str(vagrantbox) + '\"\n'
    # Create Professors array
    professors = '\tprofessors=[\n'

    p = VmObject(
        hostname=professor_hostname,
        bridge=class_config_json['bridge'],
        lab=class_config_json['lab-config'])
    professors = professors + p.deparse()

    professors = professors[:-1] + '\t]\n'

    # Creating professor's .virtualabinfo json
    pvirtualabinfo = json.loads(json.dumps(class_config_json['professor']))
    pvirtualabinfo['ip'] = '#' + p.hostname
    pvirtualabinfo['students'] = []
    # Create Students array
    students = '\tstudents=[\n'

    for student in class_config_json['students']:
        s = VmObject(
            hostname='s' + student['albumnr'],
            bridge=class_config_json['bridge'],
            lab=class_config_json['lab-config'])
        students = students + s.deparse()

        # Adding student info into professor .virtualabinfo
        student['ip'] = '#' + s.hostname
        pvirtualabinfo['students'].append(student)

        # Saving student json into .virtualabinfo
        student['professorip'] = '#' + professor_hostname
        output_file = open('data/virtualabinfo/' + s.hostname, 'w')
        output_file.write(str({'student': student}).replace('\'', '\"'))
        output_file.close()

    students = students[:-1] + '\t]\n'

    # Creating professors .virtualabinfo
    pvirtualabinfo = {'professor': pvirtualabinfo}
    output_file = open('data/virtualabinfo/' + p.hostname, 'w')
    output_file.write(str(pvirtualabinfo).replace('\'', '\"'))
    output_file.close()

    # Final step -> Write parsed vagrantfile into a file
    with open("VagrantfileFooter") as f:
        vffooter = f.read()

    output_file = open("Vagrantfile", "w")
    output_file.write(vfheader + '\n' + professors + '\n' + students + '\n' + vffooter)
    output_file.close()
    return professor_hostname