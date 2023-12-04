Vagrant.configure("2") do |config|
    config.vm.box = "bento/ubuntu-20.04"
  
    config.vm.define "wordpress" do |wordpress|
      wordpress.vm.hostname = "wordpress"
      wordpress.vm.network "private_network", ip: "192.168.33.10"
      config.vm.network "forwarded_port", guest: 80, host: 80
      wordpress.vm.provider "virtualbox" do |vb|
        vb.memory = 2048
      end
  
      config.vm.provision "chef_solo" do |chef|
        chef.cookbooks_path = "cookbooks"
    
        chef.add_recipe "apache2"
        chef.add_recipe "mysql::server"
        chef.add_recipe "php"
        chef.add_recipe "wordpress"
        chef.arguments = '--chef-license accept'
      end
    end
  end