shared_examples "a contentable model" do

  it { should have_many :contents }
  it { should allow_mass_assignment_of :contents_attributes }

  context 'when it has many contents' do
    it {should respond_to(:content)}
    it {should respond_to(:title)}
    it {should respond_to(:text)}
    it {should respond_to(:excerpt)}
    it {should respond_to(:keywords)}
    it {should respond_to(:image)}
  end

end