# Verificar si el directorio de WordPress existe
describe file('/var/www/html/wp-admin') do
    it { should exist }
    it { should be_directory }
  end
  

# Verificar si el archivo de configuración de WordPress existe
describe file('/var/www/html/wp-config.php') do
    it { should exist }
    it { should be_file }
end