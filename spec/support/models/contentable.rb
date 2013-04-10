shared_examples "a contentable model" do

  it { should have_many :contents }
  it { should allow_mass_assignment_of :contents_attributes }

end