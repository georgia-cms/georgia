require 'rails_helper'

describe Georgia::UiSection, type: :model do

  specify {expect(build(:georgia_ui_section)).to be_valid}

  it { expect(subject).to have_many(:ui_associations) }
  it { expect(subject).to have_many(:widgets) }
  it { expect(subject).to have_many(:pages) }

  it { expect(subject).to respond_to :name }
  it { expect(subject).to validate_presence_of(:name) }
  it { expect(subject).to validate_uniqueness_of(:name) }

end