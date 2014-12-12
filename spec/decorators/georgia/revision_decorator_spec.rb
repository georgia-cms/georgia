require 'rails_helper'

describe Georgia::RevisionDecorator do

  let(:decorated_georgia_revision) { Georgia::RevisionDecorator.decorate(build(:georgia_revision)) }

  describe '#excerpt_or_text' do

    context 'with an excerpt' do

      it 'returns #excerpt' do
        decorated_georgia_revision.contents << build(:georgia_content, text: nil)
        expect(decorated_georgia_revision.excerpt_or_text).to match decorated_georgia_revision.contents.first.excerpt
      end

    end

    context 'without an excerpt' do

      it 'truncates #text' do
        decorated_georgia_revision.contents << build(:georgia_content, excerpt: nil)
        expect(decorated_georgia_revision.contents.first.text).to match /^#{decorated_georgia_revision.excerpt_or_text}.*/
      end

    end

    context 'without an excerpt or text' do

      it 'returns nil' do
        decorated_georgia_revision.contents << build(:georgia_content, text: nil, excerpt: nil)
        expect(decorated_georgia_revision.excerpt_or_text).to be_nil
      end

    end

  end

end