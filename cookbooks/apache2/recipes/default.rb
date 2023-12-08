# Instalar Apache
package 'apache2' do
  action :install
end

# Inicializar y habilitar Apache 2
service 'apache2' do
  action [:enable, :start]
end

# Ruta al archivo index.html predeterminado de Apache
default_apache_index = '/var/www/html/index.html'

# Eliminar el archivo index.html si existe
file default_apache_index do
  action :delete
  only_if { ::File.exist?(default_apache_index) }
end

#Verificar los puertos que escucha Apache
execute 'check_apache_ports' do
  command 'netstat -tuln | grep apache2'
  action :run
end