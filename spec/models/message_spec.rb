require 'spec_helper'

describe Georgia::Message do
	specify {FactoryGirl.build(:message).should be_valid}

	it {should validate_presence_of(:name)}
	it {should validate_presence_of(:email)}
	it {should validate_presence_of(:message)}
	it {should validate_presence_of(:email)}
	it {should validate_format_of(:email).with('bob@bissonnette.com')}
	it {should validate_format_of(:email).not_with('bissonnette.com')}
	it {should validate_format_of(:email).not_with('bob@bissonnette')}
	it {should validate_format_of(:email).not_with('@bissonnette.com')}
end