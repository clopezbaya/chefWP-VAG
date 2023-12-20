# Verificar si el servicio MySQL está activo y habilitado
describe service('mysql') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end