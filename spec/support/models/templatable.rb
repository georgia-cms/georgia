shared_examples "a templatable model" do

  it { should allow_mass_assignment_of :template }
  it { should allow_value('one-column').for(:template) }
  it { should_not allow_value('foobar').for(:template) }

end