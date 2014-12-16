require 'rails_helper'

describe 'Media Library', type: :feature do

  before :each do
    login_as_admin
    visit georgia.search_media_index_path
  end

  describe 'uploading' do
    it 'displays a progress bar'
    it 'adds the new file to the table'
  end

  describe 'deleting' do

    it 'deletes the asset'
    it 'removes the object from the view'

  end

  describe 'downloading' do

    it 'sends a zip folder of all selected assets'

  end

end
