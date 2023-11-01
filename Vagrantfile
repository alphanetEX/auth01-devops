vm_name = 'ub-dcmg'
Vagrant.configure("2") do |config|
   config.vm.define "dbx" do |dbx|
      dbx.vm.box = 'alphanetEX/ub-dc0'
      dbx.vm.network "private_network", ip: "10.0.0.10"
      dbx.vm.synced_folder ".", "/vagrant"
      
      #docker provision Sector
      dbx.vm.provision "docker" do |dock|
         #dock.pull_images "mongo"
         #dock.run "mongo", image "mongo"
         #dock.run "mongo", cmd: "echo $HOME"
         #dock.run "ubuntu:18.04", args: "--name turbuntu"
         #dock.run "nginx", auto_assing_name: false 
         #dock.build_image "/vagrant/provision", args: "--pull"
      end 
     #virtual machine configuration 
     
      dbx.vm.provider "parallels" do |prl|
         prl.name = vm_name                   
         prl.memory = 1536
         prl.cpus = 2
         unless File.exist?('/Users/alphanet/Parallels/ub-dcmg.pvm/harddisk2.hdd')
         prl.customize ['set','ub-dcmg', '--device-add', 'hdd' , '--type', 'expand', '--size', 40 * 1024, '--split', '--iface', 'sata', '--position', '3']
         end
         prl.customize ['set', vm_name, '--show-dev-tools', 'on']
         prl.customize ['set', vm_name, '--resource-quota', 'unlimited']
         prl.customize ['set', vm_name, '--3d-accelerate', 'off', '--vertical-sync', 'off', '--high-resolution', 'off']
         #prl.customize ['set', vm_name, '--device-add', 'net', '--type', 'host-only', '--iface', 'VLAN_100', '--mac', 'auto', '--dhcp', 'yes', '--dhcp6', 'no', '--gw', '10.0.1.1', '--adapter-type', 'virtio']
         #prl.customize ['set', vm_name, '--device-add', 'net', '--type', 'host-only', '--iface', 'VLAN_200', '--mac', 'auto', '--dhcp', 'yes', '--dhcp6', 'no', '--gw', '192.168.3.1', '--adapter-type', 'virtio']
      end

      dbx.vm.provision "shell", inline: <<-SHELL
      SHELL

      dbx.vm.provision :shell do |shell|
      shell.path = "root.sh"
      end
   end
end
