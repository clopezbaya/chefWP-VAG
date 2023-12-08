require 'chefspec'

describe 'apache2::default' do

  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '20.04').converge(described_recipe) }

  it 'Verificar la instalacion de Apache' do
    expect(chef_run).to install_package('apache2')
  end

  it 'Verificar si el servicio esta Activo' do
    expect(chef_run).to enable_service('apache2')
  end

  # Se hiso fallar al intento al cambiar el apache2 por apache10
  it 'Verificar si el servicio se Inicio' do
    expect(chef_run).to start_service('apache10')
  end

  it 'Verificar que Apache estee Escuchando en los Puertos' do
    expect(chef_run).to run_execute('check_apache_ports')
      .with(command: 'netstat -tuln | grep apache2')
  end

end