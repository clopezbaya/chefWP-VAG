# Instalar MySQL
package 'mysql-server' do
    action :install
end

service 'mysql' do
    action [:start, :enable]
end

# Creacion de la base de datos y Usuario Wordpress
execute 'create_mysql_database' do
    command <<-EOH
      mysql -u root -e "CREATE DATABASE wordpress;"
      mysql -u root -e "CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY 'root';"
      mysql -u root -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpressuser'@'localhost';"
      mysql -u root -e "FLUSH PRIVILEGES;"
    EOH
    action :run
end

  