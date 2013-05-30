shared_examples "a revisionable model" do

  it { should belong_to :current_revision }
  it { should_not allow_mass_assignment_of :revision_id }

  it "should make sure all the associations are recovered"

end