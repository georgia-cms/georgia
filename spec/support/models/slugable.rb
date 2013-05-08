shared_examples "a slugable model" do

  let(:model_name) { described_class.name.underscore.gsub(/\//, '_').to_sym }

  it { should allow_mass_assignment_of :slug }
  it { should_not allow_mass_assignment_of :url }

  it {should allow_value('contact').for(:slug)}
  it {should allow_value('COn-T4CT_').for(:slug)}
  it {should allow_value('/register-me//').for(:slug)}
  it {should_not allow_value('supp/ort').for(:slug).with_message(/can only consist of/)}

  it 'sanitizes the slug by removing the first and last forward slashes' do
    instance = FactoryGirl.create(model_name, slug: '///leftover//')
    expect(instance.slug).to eq('leftover')
  end


  describe  '#url' do

    it "prepares url unless slug_changed? or one of the ancestors' slug changed"

    it 'returns a relative path' do
      page = FactoryGirl.create(:georgia_page, slug: 'relative')
      expect(page.url).to eq '/relative'
    end

    context 'with ancestry' do

      it 'prepends the ancestors slugs' do
        root = FactoryGirl.create(:georgia_page, slug: 'parent')
        descendant = FactoryGirl.create(:georgia_page, slug: 'kid', parent: root)
        page = FactoryGirl.create(:georgia_page, slug: 'gong', parent: descendant)
        expect(page.url).to eq '/parent/kid/gong'
      end

    end

  end

end