# Verificar si Apache2 esta instalado
describe package('apache2') do
  it { should be_installed }
end

# Verificar si Apache2 esta instalado, habilitado y corriendo
describe service('apache2') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end
