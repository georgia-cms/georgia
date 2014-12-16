require 'rails_helper'

describe Georgia::Menu, type: :model do

  specify { expect(build(:georgia_menu)).to be_valid}
  it { is_expected.to have_many :links }
  it { is_expected.to respond_to :name }

end