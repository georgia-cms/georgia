== 0.7.6

- Fixes Georgia::Indexer extensions loading pattern
- Fixes issue where slides would not follow provided locale

== 0.7.5

- Fixes require on missing dependencies

== 0.7.4

- Fixes ckeditor
- Removes cloudfiles
- Fixes Tire Georgia::Message indexing
- Removes helpers loading in main_app
- Fixes Georgia::Indexer
- Moves Georgia::Message handling to GeorgiaMailer (georgia_mailer gem)

== 0.7.3

- Added docs
- Added Travis CI support
- Passing test suite

== 0.7.2

- Can deploy on Heroku!
- Added support for [Tire](https://github.com/karmi/retire)

== 0.7.1

- Minor bug fixes
- UI fixes
- Fixes georgia:install generator

== 0.7.0

- Fixes flow when creating multiple drafts simply to view editable content
- UI improvements
- Widgets editable in their own view
- No more AJAX record updates, you need to submit form for any change to take effect
- Adds facets on search results with filter bar
- Removes dependency on Henry
- Removes dependency on Backbone
- Can replace asset files
- Adds searchable/pageable media library for selecting featured images and slide images
- Adds dashboard to display latest messages and awaiting revisions

== 0.6.16

- Fixes missing edit_revision_url error in revisions_controller

== 0.6.15

- Add sidekiq:clear_queue rake task

== 0.6.14

- Add locale to caching

== 0.6.13

- Add caching by default on pages#show

== 0.6.12 (yanked)

== 0.6.11

- Add solr tasks to reindex by model (pages, messages & assets)

== 0.6.10

- Messages are sent even in dev and test mode (use letter_opener)
- Messages list can be sorted by header

== 0.6.9

- Fight back UTF-8 Invalid Byte Sequences
- MessagesController redirects to :back on create in html format

== 0.6.8

- Fix ordering slides in Backbone

== 0.6.7

- Minor bugs and fixes

== 0.6.6

- Fix jquery-file-upload to add files directly to table
- Remove pg_search implementation on Tags and add to solr

== 0.6.5

- Add contents counter cache to Ckeditor::Asset
- Fix media library speed issue
- Fix install generator

== 0.6.4

- Add rakismet to avoid spam
- Revamp messages dashboard on solr
- Fix UI issues with media library
- Fix users editing
- Add meta_description, different to excerpt_or_text
- Order by updated_at

== 0.6.3

- Fix navigation menus editing
- Fix Backbone slides and widgets
- Fix small bugs introduce from new revisioning flow

== 0.6.2

- Remove MetaPage and move references back to Page
- Add default template
- Introduce Georgia::Revision

== 0.6.1

- Fix messages view
- Use Bootstrap CDN for font-awesome Twitter Bootstrap & Font-Awesome
- Move path discovery to its own module (Georgia::Paths)

== 0.6.0

- Add uuid to Georgia::Page to links between revisions of the same page
- Add frontable controller concern: show and preview of Georgia::Page based on request url
- Add state_machine on Georgia::Page
- Fix Georgia::Page and Georgia::MetaPage inheritance through concerns and STI
- Add Clone class to handle cloning
- Add Publisher class to handle the various state a Page goes through before getting published

== 0.5.2

- Add 'wait-and-spin' to menu saving button
- Add clonable concern to create a clone of a specific Georgia::Page
- Replace ActsAsRevisionable by full copies of a Georgia::Page and its associations on publishing/storing

== 0.5.1

- Fix menu editing jquery autocomplete error
- Fix tags editing on picture assets
- Use font-awesome-rails instead of font-awesome-sass-rails
- Fix url updating on ancestry
- Add visit button on page#edit
- Remove image panel carousel
- Add photoshop-like bg behind images to show transparency
- Add Guest role

== 0.5.0

- Revamp Media Library
- Fix contents excerpt from string to text

== 0.4

- Add rackspace_region: :ord to your carrierwave file
- Index pages with Sunspot
- Add phone to messages
- Add Concerns on Controllers
- Add position to widgets
- Add inheritance on pages
- Revamp slug & parents with new url attribute

== 0.3

- Add Media Library
- Add Concerns on Models