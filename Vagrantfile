Vagrant.configure("2") do |config|

    professors=[
    {
        :hostname => "Professor1",
        :box => "socialwifi/ubuntu-gui",
        :ip => "192.168.101.2",
        :ssh_port => '2200'
    }
    ]

    students=[
        {
          :hostname => "Student1",
          :box => "socialwifi/ubuntu-gui",
          :ip => "192.168.101.3",
          :ssh_port => '2201'
        }
      ]

    professors.each do |machine|
        config.vm.define machine[:hostname] do |node|
            node.vm.box = machine[:box]
            node.vm.hostname = machine[:hostname]
            node.vm.network :public_network, bridge: "eth0", ip: machine[:ip]
            node.vm.network "forwarded_port", guest: 22, host: machine[:ssh_port], id: "ssh"
            node.vm.synced_folder "data/", "/home/vagrant/data"
            node.vm.synced_folder "Shared/", "/home/vagrant/Shared"
            # config.vm.provision "file", source: "~/.gitconfig", destination: ".gitconfig"
            node.vm.provision "shell" do |s|
                s.inline = "chmod +x /home/vagrant/data/install.sh; bash /home/vagrant/data/install.sh professor"
                end

            node.vm.provider :virtualbox do |vb|
                vb.customize ["modifyvm", :id, "--memory", 1024]
                vb.customize ["modifyvm", :id, "--cpus", 1]
            end
        end
    end

    students.each do |machine|
        config.vm.define machine[:hostname] do |node|
            node.vm.box = machine[:box]
            node.vm.hostname = machine[:hostname]
            node.vm.network :public_network, bridge: "eth0", ip: machine[:ip]
            node.vm.network "forwarded_port", guest: 22, host: machine[:ssh_port], id: "ssh"
            node.vm.synced_folder "data/", "/home/vagrant/data"
            node.vm.synced_folder "Shared/", "/home/vagrant/Shared"
            # config.vm.provision "file", source: "~/.gitconfig", destination: ".gitconfig"
            node.vm.provision "shell" do |s|
                s.inline = "chmod +x /home/vagrant/data/install.sh; bash /home/vagrant/data/install.sh student"
                end

            node.vm.provider :virtualbox do |vb|
                vb.customize ["modifyvm", :id, "--memory", 1024]
                vb.customize ["modifyvm", :id, "--cpus", 1]
            end
        end
    end
end
