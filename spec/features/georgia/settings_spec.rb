require 'spec_helper'

describe 'Georgia' do

  describe '#title' do

    context 'by default' do
      it 'uses the application name' do
        visit georgia.root_url
        expect(page).to have_title "Dummy App CMS"
      end
    end

    context 'when set in initializer' do

      it 'uses the initializer value' do
        Georgia.stub(:title).and_return('Foo Bar')
        visit georgia.root_url
        expect(page).to have_title "Foo Bar CMS"
      end

    end

  end

end