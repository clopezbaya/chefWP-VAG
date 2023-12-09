case node[:platform]
when 'ubuntu'
       

        execute "Actualizar paquetes" do
            command "apt-get update"
        end

        # modeapp = "755"

        # ["/var/www/","/var/www/app"].each do |myDir|
        #     directory myDir do
        #     owner 'root'
        #     group 'root'
        #     recursive true
        #     mode "#{modeapp}"
        #     end
        # end
end       

if platform?('centos')

    execute "Install-repo" do
        command "sudo yum install epel-release -y;sudo yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y"
    end

    # Install and configure Apache
    package %w(mariadb-server httpd httpd-tools curl php72 php72-php-cli php72-php-json php72-php-gd php72-php-mbstring php72-php-pdo php72-php-xml php72-php-mysqlnd) do
        action :install
    end

    #Modificar ejecutable
    execute "mod-excute" do
        command "sudo mv /usr/bin/php72 /usr/bin/php"
    end

    execute "Install WP CLI" do
        command "curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/bin/wp"
    end

    service 'httpd' do
        supports :status => true
        action :nothing
    end

    directory '/var/www/app' do
        owner "apache"
        group "apache"
        mode "775"
        action :create
    end

    directory '/var/www/app/wordpress' do
        owner "apache"
        group "apache"
        mode "775"
        action :create
    end 
    
    template "#{node['centos']['httpd_site_path']}/wordpress.conf" do
        source 'virtual-hosts_centos.conf.erb'
    end

    execute "restart-httpd" do
        command "sudo systemctl restart httpd"
    end

    execute "restart-database" do
        command "sudo systemctl enable --now mariadb"
    end

    mysqlPassword = "wordpress"

    execute "set_mysql_password" do
        command "/usr/bin/mysqladmin -u root password ${mysqlPassword}"
        action :run
        only_if "/usr/bin/mysql -u root -e 'show databases;'"
    end

    file '/var/lib/mysql/my.cnf' do
        owner 'mysql'
        group 'mysql'
        action :create_if_missing
    end
    
      
    file '/etc/my.cnf' do
        owner 'mysql'
        group 'mysql'
        action :create_if_missing
    end


    execute "create_database" do
        command "mysql -uroot -p${mysqlPassword} -e \'create database if not exists test\'"
    end
    
end    