require 'spec_helper'

describe Georgia::MessageDecorator do

  subject {Georgia::MessageDecorator.decorate(FactoryGirl.build(:georgia_message))}

  it_behaves_like 'a decorator'
  it { should respond_to :description}

end