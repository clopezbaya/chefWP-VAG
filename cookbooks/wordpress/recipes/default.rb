
# Descarga Wordpress
remote_file '/tmp/latest.tar.gz' do
    source 'https://wordpress.org/latest.tar.gz'
    action :create
end
 
# Creacion de Ruta
directory '/var/www/html' do
  action :create
  recursive true
end
  
# Extraccion de Wordpress
execute 'extract_wordpress' do
  command 'tar -C /var/www/html -zxvf /tmp/latest.tar.gz --strip-components=1'
  action :run
  not_if { ::File.exist?('/var/www/html/wp-config.php') }
end

# Configuracion de Wordpres con la DB
template '/var/www/html/wp-config.php' do
  source 'wp-config.php.erb'
  owner 'www-data'
  group 'www-data'
  mode '0644'
  variables(
    db_name: 'wordpress',
    db_user: 'wordpressuser',
    db_password: 'root',
    db_host: 'localhost',
    db_prefix: 'wp_'
  )
end

# Configuracion de PHP como requerimiento de Wordpress
template '/etc/php/7.4/apache2/conf.d/20-mysqli.ini' do
  source 'php.ini.erb'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  notifies :restart, 'service[apache2]', :immediately
end

# Instalacion de Wordpress con Datos Necesarios
execute 'install_wordpress' do
  command <<-EOH
      curl -d "weblog_title=HOLA-GRUPO&user_name=unir&admin_password=root&admin_password2=root&admin_email=unir-grupo-automatizacion-despliegues@gmail.com" http://localhost/wp-admin/install.php?step=2
      EOH
      action :run
end
