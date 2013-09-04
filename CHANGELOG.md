== 0.6.5

- Add contents counter cache to Ckeditor::Asset

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