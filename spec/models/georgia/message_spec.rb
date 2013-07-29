require 'spec_helper'

describe Georgia::Message do
  specify {FactoryGirl.build(:georgia_message).should be_valid}

  it { should respond_to :name, :email, :subject, :message, :attachment }

  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:message)}

  it {should allow_value('whereis@waldo.com').for(:email)}
  it {should_not allow_value('waldo.com').for(:email)}
  it {should_not allow_value('whereis@waldo').for(:email)}
  it {should_not allow_value('@waldo.com').for(:email)}

  # FIXME: Georgia::Message should be on solr instead of pg_search
  # it_behaves_like 'a searchable model'

end