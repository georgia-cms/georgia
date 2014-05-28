require 'spec_helper'

describe Georgia::RevisionDecorator do

  subject {Georgia::RevisionDecorator.decorate(FactoryGirl.build(:georgia_revision))}

  it {should respond_to :excerpt_or_text}

  describe '#excerpt_or_text' do

    context 'with an excerpt' do

      it 'returns #excerpt' do
        revision = Georgia::RevisionDecorator.decorate(build(:georgia_revision))
        revision.contents << build(:georgia_content, text: nil)
        revision.excerpt_or_text.should match revision.contents.first.excerpt
      end

    end

    context 'without an excerpt' do

      it 'truncates #text' do
        revision = Georgia::RevisionDecorator.decorate(build(:georgia_revision))
        revision.contents << build(:georgia_content, excerpt: nil)
        revision.contents.first.text.should match /^#{revision.excerpt_or_text}.*/
      end

    end

    context 'without an excerpt or text' do

      it 'returns nil' do
        revision = Georgia::RevisionDecorator.decorate(build(:georgia_revision))
        revision.contents << build(:georgia_content, text: nil, excerpt: nil)
        revision.excerpt_or_text.should be_nil
      end

    end

  end

end