shared_examples "a slugable model" do

  let(:model_name) { described_class.name.underscore.gsub(/\//, '_').to_sym }

  it { should allow_mass_assignment_of :slug }

  it {should validate_uniqueness_of(:slug).scoped_to(:ancestry)}

  it {should allow_value('contact').for(:slug)}
  it {should allow_value('COn-T4CT_').for(:slug)}
  it {should allow_value('/register-me//').for(:slug)}
  it {should_not allow_value('supp/ort').for(:slug).with_message(/can only consist of/)}

  it 'sanitizes the url by removing the first and last forward slashes' do
    instance = FactoryGirl.build(model_name, slug: '///leftover//')
    instance.valid?.should be_true #triggers validations
    instance.slug.should eq('leftover')
  end

end