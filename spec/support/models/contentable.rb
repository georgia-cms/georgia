shared_examples "a contentable model" do

  it { expect(subject).to have_many :contents }

  context 'when it has many contents' do
    it { expect(subject).to respond_to(:content)}
    it { expect(subject).to respond_to(:title)}
    it { expect(subject).to respond_to(:text)}
    it { expect(subject).to respond_to(:excerpt)}
    it { expect(subject).to respond_to(:keywords)}
    it { expect(subject).to respond_to(:keyword_list)}
    it { expect(subject).to respond_to(:image)}
  end

end