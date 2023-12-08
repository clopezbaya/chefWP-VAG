require 'chefspec'

describe 'php::default' do

  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '20.04').converge(described_recipe) }

  it 'Verificar la instalacion de PHP' do
    expect(chef_run).to install_package('php')
  end

  it 'Verificar la instalacion de PHP-Mysql service' do
    expect(chef_run).to install_package('php-mysql')
  end

  # Se hiso fallar al intento al cambiar el php-mysqli por php-fake
  it 'Verificar la instalacion de PHP-Mysqi service' do
    expect(chef_run).to install_package('php-fake')
  end
end