require 'spec_helper'

describe Georgia::Message do
  specify {FactoryGirl.build(:message).should be_valid}

  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:email)}
  it {should validate_presence_of(:message)}
  it {should validate_presence_of(:email)}
  it {should allow_value('whereis@waldo.com').for(:email)}
  it {should_not allow_value('waldo.com').for(:email)}
  it {should_not allow_value('whereis@waldo').for(:email)}
  it {should_not allow_value('@waldo.com').for(:email)}
end