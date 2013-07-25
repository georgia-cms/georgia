class Georgia::MetaPageObserver < ActiveRecord::Observer

  observe Georgia::MetaPage

  def before_create(page)
    page.uuid ||= UUIDTools::UUID.timestamp_create.to_s
  end

  def before_publish(page, transition)
    page.update_attribute(:published_at, Time.zone.now)
  end

end