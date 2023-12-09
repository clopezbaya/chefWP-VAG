require 'spec_helper'

describe file('/var/www/app') do
  it { should be_directory }
end

describe file('/var/www/app/wordpress/wp-config.php') do
  it { should exist }
end

describe package('mysql-server') do , if: os[:family] == 'ubuntu' do
  it {should be_installed}
end
