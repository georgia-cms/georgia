# encoding: UTF-8
require 'spec_helper'

describe InternationalizationHelper do

  it "should return true to french? if locale is 'fr'" do
    I18n.locale = :fr
    helper.french?.should be_true
    I18n.locale = :en
    helper.french?.should be_false
  end

  it "should return true to english? if locale is 'en'" do
    I18n.locale = :en
    helper.english?.should be_true
    I18n.locale = :fr
    helper.english?.should be_false
  end

  it "should return a link to the french locale for the same page" do
    I18n.locale = :en
    helper.link_to_locale.should eq link_to('Français', url_for(:locale => :fr), :hreflang => :fr)
  end

  it "should return a link to the english locale for the same page" do
    I18n.locale = :fr
    helper.link_to_locale.should eq link_to('English', url_for(:locale => nil), :hreflang => :en)
  end

end