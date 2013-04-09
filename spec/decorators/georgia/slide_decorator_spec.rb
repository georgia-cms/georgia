require 'spec_helper'

describe Georgia::SlideDecorator do

  subject {Georgia::SlideDecorator.decorate(FactoryGirl.build(:slide))}

  it_behaves_like 'a decorator'

end