require 'spec_helper'

describe Georgia::UserDecorator do

  subject {Georgia::UserDecorator.decorate(FactoryGirl.build(:georgia_user).decorate)}

  it_behaves_like 'a decorator'
  it {should respond_to :name}
  it {should respond_to :roles_names}

  describe '#name' do

    it "should match the first and last name" do
      user = Georgia::UserDecorator.decorate(FactoryGirl.build(:georgia_user, first_name: 'Bob', last_name: 'Bison'))
      user.name.should match 'Bob Bison'
    end

  end

  describe '#roles_names' do

    it "is pending"

  end


end