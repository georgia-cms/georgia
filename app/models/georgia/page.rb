module Georgia
  class Page < ActiveRecord::Base

    include Georgia::Concerns::Taggable
    include Georgia::Concerns::Orderable
    include Georgia::Concerns::Slugable
    include Georgia::Concerns::Revisionable
    include Georgia::Concerns::Publishable
    include Georgia::Concerns::Indexable
    include Georgia::Concerns::Copyable
    include Georgia::Concerns::Treeable
    include Georgia::Concerns::Cacheable

    acts_as_list scope: :parent #override Concerns::Orderable to include scope

    paginates_per 20

    scope :not_self, ->(page) {where('georgia_pages.id != ?', page.id)}

  end
end