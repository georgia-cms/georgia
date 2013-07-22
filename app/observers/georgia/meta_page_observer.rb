class Georgia::MetaPageObserver < ActiveRecord::Observer

  observe Georgia::MetaPage

  def before_create(page)
    page.uuid ||= UUIDTools::UUID.timestamp_create.to_s
  end

  # Publish

  def before_publish(page, transition)
    page.published_at = Time.zone.now
    page.store_as_revision
  end

  def after_publish(page, transition)
    # notify editors
  end

  # Draft

  def before_draft(page, transition)
  	page.store_as_draft
  end

  # Revision

  def before_store(page, transition)
  	page.store_as_revision
  end

  # Unpublish

  def after_unpublish(page, transition)
    # notify editors
  end

  # Review

  def before_ask_for_review(page, transition)
    page.store_as_review
  end

  def after_ask_for_review(page, transition)
    # notify reviewers
  end

end