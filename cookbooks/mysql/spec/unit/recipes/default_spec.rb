require 'chefspec'

describe 'mysql::server' do

  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '20.04').converge(described_recipe) }

  it 'Verificar la instalacion de los paquetes de MySQL' do
    expect(chef_run).to install_package('mysql-server')
  end

  it 'Verificar si esta habilitado e inicializado MySQL service' do
    expect(chef_run).to start_service('mysql')
    expect(chef_run).to enable_service('mysql')
  end
end