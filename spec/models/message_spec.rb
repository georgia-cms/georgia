require 'spec_helper'

describe Georgia::Message do
	specify {FactoryGirl.build(:message).should be_valid}

	it {should validate_presence_of(:name)}
	it {should validate_presence_of(:email)}
	it {should validate_presence_of(:message)}
	it {should validate_presence_of(:email)}
	it {should validate_format_of(:email).with('whereis@waldo.com')}
	it {should validate_format_of(:email).not_with('waldo.com')}
	it {should validate_format_of(:email).not_with('whereis@waldo')}
	it {should validate_format_of(:email).not_with('@waldo.com')}
end