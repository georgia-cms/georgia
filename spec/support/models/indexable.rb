shared_examples "a indexable model" do

  let(:model_name) { described_class.name.underscore.gsub(/\//, '_').to_sym }
  let(:instance) { create(model_name) }

  describe 'searching' do

    it "should respond to .search" do
      described_class.should respond_to :search
    end

    it 'in full text mode by query' do
      revision = create(:georgia_revision)
      revision.contents << build(:georgia_content, title: 'Wise Wiesel')
      instance.revisions << revision
      instance.current_revision = revision
      instance.save
      described_class.reindex
      search = described_class.search do
        fulltext 'Wise' do
          fields(:title)
        end
      end
      expect(search.results).to include(instance)
    end

  end

end