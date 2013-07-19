class Georgia::PublishingObserver < ActiveRecord::Observer

  observe Georgia::Page

  def before_publish(page, transition)
    page.published_at = Time.zone.now
    page.store_as_revision
    #Georgia::Revision.clone(page)
  end

end