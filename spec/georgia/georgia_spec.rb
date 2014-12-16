require 'rails_helper'

describe Georgia do

  it {should respond_to :templates }
  it {should respond_to :title }
  it {should respond_to :url }
  it {should respond_to :navigation }
  it {should respond_to :storage }

  context 'defaults' do

    it 'assigns template' do
      expect(Georgia.templates).to eq %w(default)
    end

    it 'assigns url' do
      expect(Georgia.url).to eq "http://www.example.com"
    end

    it 'assigns navigation' do
      expect(Georgia.navigation).to eq %w(dashboard pages media navigation widgets)
    end

    it 'assigns storage' do
      expect(Georgia.storage).to eq :file
    end

  end

  describe '.setup' do

    before :each do
      Georgia.setup do |config|
        config.templates = %w(Foo)
        config.url = 'Foo'
        config.navigation = %w(foo)
        config.storage = :fog
      end
    end

    it 'assigns template' do
      expect(Georgia.templates).to eq %w(Foo)
    end

    it 'assigns url' do
      expect(Georgia.url).to eq 'Foo'
    end

    it 'assigns navigation' do
      expect(Georgia.navigation).to eq %w(foo)
    end

    it 'assigns storage' do
      expect(Georgia.storage).to eq :fog
    end

    it 'deprecates config.header' do
      ActiveSupport::Deprecation.should_receive(:warn)
      Georgia.setup do |config|
        config.header = %w(foo)
      end
    end

  end

end