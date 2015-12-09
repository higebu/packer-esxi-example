File.open("version.txt", 'w') do |f|
  f.write(Vagrant::VERSION)
end

Vagrant.configure("2") do |config|
  config.ssh.default.username = "root"
  config.ssh.shell = "sh"
  config.ssh.insert_key = false

  config.vm.hostname = "vagrantbox"
  config.vm.box = "esxi"
  config.vm.synced_folder ".", "/vagrant", nfs: true

  [:vmware_fusion, :vmware_workstation].each do |name|
    config.vm.provider name do |v,override|
      v.vmx["memsize"] = "4096"
    end
  end

  config.vm.provision "shell", privileged: false, path: "provision.sh"

  config.trigger.after :up do
    output = `vagrant ssh -c 'esxcli --formatter csv network ip interface ipv4 get' | grep vmk0 | awk -F, '{print $3}'`
	ip_addr = output.strip
    puts "==> #{@machine.name}: Available on DHCP IP address #{ip_addr}"
    run "packer build -var remote_host=#{ip_addr} template.json"
  end
end
