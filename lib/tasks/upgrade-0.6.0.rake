# namespace :georgia do

#   namespace :upgrade do

#     desc "Move Georgia::Status to OO Page"
#     task statuses: :environment do
#       puts "Initialize all pages with state 'draft'"
#       Georgia::Page.update_all(state: 'draft')

#       puts "Initialize all 'real' pages (no subclasses) as MetaPage"
#       Georgia::Page.where(type: nil).update_all(type: 'Georgia::MetaPage')

#       puts "Publish all used-to-be published pages"
#       published_status = Georgia::Status.find_by_name('Published')
#       published_status.pages.find_each do |page|
#         page.publish
#       end
#     end

#     desc "Create a UUID per page"
#     task uuid: :environment do
#       puts 'Setting UUID on all pages'
#       Georgia::Page.find_each do |page|
#         page.update_attribute(:uuid, UUIDTools::UUID.timestamp_create.to_s)
#       end
#     end

#     desc "Reindex everything for good measure"
#     task reindex: :environment do
#       puts "Reindex everything for good measure"
#       Georgia::Page.reindex
#     end

#   end

# end