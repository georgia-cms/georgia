require 'rails_helper'

describe Georgia do

  it {should respond_to :templates }
  it {should respond_to :title }
  it {should respond_to :url }
  it {should respond_to :navigation }
  it {should respond_to :storage }

  describe '.templates' do
    it 'defaults to 4 main ones' do
      expect(Georgia.templates).to eq %w(default one-column sidebar-left sidebar-right)
    end
  end

  describe '.url' do
    it 'defaults to example.com' do
      expect(Georgia.url).to eq "http://www.example.com"
    end
  end

  describe '.navigation' do
    it 'defaults to all' do
      expect(Georgia.navigation).to eq %w(dashboard pages media navigation widgets)
    end
  end

  describe '.storage' do
    it 'defaults to :file' do
      expect(Georgia.storage).to eq :file
    end
  end

  describe '#setup' do
    it 'loads and assigns' do
      Georgia.setup{|config| config.url = 'Foo'}
      expect(Georgia.url).to eq "Foo"
    end
    it 'deprecates config.header' do
      ActiveSupport::Deprecation.should_receive(:warn)
      Georgia.setup do |config|
        config.header = %w(foo)
      end
    end
  end

end