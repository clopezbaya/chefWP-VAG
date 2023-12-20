# Verificar si PHP esta instalado
describe package('php') do
    it { should be_installed }
end
 
# Verificar la version de PHP
describe command('php -v') do
  its('stdout') { should match (/PHP [\d\.]+/) }
  its('exit_status') { should eq 0 }
end
