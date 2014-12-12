require 'rails_helper'

describe Georgia::SlideDecorator do

  subject {Georgia::SlideDecorator.decorate(FactoryGirl.build(:georgia_slide))}

end