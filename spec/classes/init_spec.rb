require 'spec_helper'
describe 'amitools' do

  context 'with defaults for all parameters' do
    it { should contain_class('amitools') }
  end
end
