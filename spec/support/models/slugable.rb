shared_examples "a slugable model" do

  let(:model_name) { described_class.name.underscore.gsub(/\//, '_').to_sym }

  it { should allow_mass_assignment_of :slug }
  it { should allow_mass_assignment_of :url }

  it {should allow_value('contact').for(:slug)}
  it {should allow_value('COn-T4CT_').for(:slug)}
  it {should allow_value('/register-me//').for(:slug)}
  it {should_not allow_value('supp/ort').for(:slug).with_message(/can only consist of/)}

  it 'sanitizes the slug by removing the first and last forward slashes' do
    instance = FactoryGirl.create(model_name, slug: '///leftover//')
    expect(instance.slug).to eq('leftover')
  end


  describe  '#url' do

    it 'returns a relative path' do
      page = FactoryGirl.create(:georgia_page, slug: 'relative')
      expect(page.url).to eq '/relative'
    end

    it "prepares url unless slug_changed? or one of the ancestors' slug changed" do
      page = FactoryGirl.create(:georgia_page)
      page.should_receive(:slug_changed?).once
      page.should_not_receive(:update_column)
      page.save
    end

    context 'with ancestry' do

      it 'updates the descendants url' do
        what = FactoryGirl.create(:georgia_page, slug: 'what')
        who = FactoryGirl.create(:georgia_page, slug: 'who', parent: what)
        how = FactoryGirl.create(:georgia_page, slug: 'how', parent: who)
        expect(what.url).to eq  '/what'
        expect(who.url).to  eq  '/what/who'
        expect(how.url).to  eq  '/what/who/how'

        what.slug = 'why'
        what.save!

        # update_column doesn't update rspec variable
        # fetch again to make sure the url has changed
        why = Georgia::Page.find_by_url('/why')
        who = Georgia::Page.find_by_url('/why/who')
        how = Georgia::Page.find_by_url('/why/who/how')

        expect(why.url).to eq '/why'
        expect(who.url).to eq '/why/who'
        expect(how.url).to eq '/why/who/how'
      end

    end

  end

end