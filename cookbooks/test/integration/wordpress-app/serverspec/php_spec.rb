require 'spec_helper'

describe package('php'), if: os[:family] == 'ubuntu' do
  it { should be_installed }
end

describe package('php-mysql'), if: os[:family] == 'ubuntu' do
  it { should be_installed }
end

describe package('php72') do, if: os[:family] == 'redhat' do
  it { should be_installed }
end

describe package('php72-php-mysqlnd') do, if: os[:family] == 'redhat' do
  it { should be_installed }
end
