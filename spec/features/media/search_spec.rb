require 'spec_helper'

describe 'media#search' do

  before :each do
    Ckeditor::Asset.tire.index.delete
    Ckeditor::Picture.tire.index.delete
    Ckeditor::Asset.tire.create_elasticsearch_index
    Ckeditor::Picture.tire.create_elasticsearch_index
    login_as_admin
    visit georgia.search_media_index_path
  end

  describe 'uploading' do
    it 'displays a progress bar'
    it 'adds the new file to the table'
  end

  describe 'table actions' do

    it 'lets a user select a row', js: true
    it 'lets a user delete multiple assets', js: true
    it 'lets a user download multiple assets', js: true

  end

end
