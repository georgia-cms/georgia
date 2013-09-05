require 'spec_helper'

describe Georgia::MessageDecorator do

  subject {Georgia::MessageDecorator.decorate(FactoryGirl.build(:georgia_message))}

end