module Georgia
  module Permissions

    CONTENT_PERMISSIONS = {
      show_pages:       { guest: true,  contributor: true,     editor: true, admin: true, },
      preview_pages:    { guest: true,  contributor: true,     editor: true, admin: true, },
      copy_pages:       { guest: false, contributor: true,     editor: true, admin: true, },
      create_pages:     { guest: false, contributor: true,     editor: true, admin: true, },
      update_pages:     { guest: false, contributor: :partial, editor: true, admin: true, },
      delete_pages:     { guest: false, contributor: :partial, editor: true, admin: true, },
      copy_pages:       { guest: false, contributor: true,     editor: true, admin: true, },
      manage_widgets:   { guest: false, contributor: false,    editor: true, admin: true, },
    }
    PUBLISHING_PERMISSIONS = {
      show_revisions:      { guest: false, contributor: true,  editor: true, admin: true, },
      create_new_revision: { guest: false, contributor: true,  editor: true, admin: true, },
      review_changes:      { guest: false, contributor: false, editor: true, admin: true, },
      revert_changes:      { guest: false, contributor: false, editor: true, admin: true, },
      publish_pages:       { guest: false, contributor: false, editor: true, admin: true, },
      upublish_pages:      { guest: false, contributor: false, editor: true, admin: true, },
    }
    MEDIA_LIBRARY_PERMISSIONS = {
      show_media_assets:   { guest: true,  contributor: true,     editor: true, admin: true, },
      upload_media_assets: { guest: false, contributor: true,     editor: true, admin: true, },
      update_media_assets: { guest: false, contributor: :partial, editor: true, admin: true, },
      delete_media_assets: { guest: false, contributor: :partial, editor: true, admin: true, },
    }
    NAVIGATION_PERMISSIONS = {
      show_menus:   { guest: false, contributor: false, editor: true, admin: true, },
      create_menus: { guest: false, contributor: false, editor: true, admin: true, },
      update_menus: { guest: false, contributor: false, editor: true, admin: true, },
      delete_menus: { guest: false, contributor: false, editor: true, admin: true, },
    }
    USERS_PERMISSIONS = {
      show_users:   { guest: false, contributor: false, editor: true,  admin: true, },
      create_users: { guest: false, contributor: false, editor: false, admin: true, },
      update_users: { guest: false, contributor: false, editor: false, admin: true, },
      delete_users: { guest: false, contributor: false, editor: false, admin: true, },
    }

    DEFAULT_PERMISSIONS = {
      content: CONTENT_PERMISSIONS,
      publishing: PUBLISHING_PERMISSIONS,
      media_library: MEDIA_LIBRARY_PERMISSIONS,
      navigation: NAVIGATION_PERMISSIONS,
      users: USERS_PERMISSIONS,
    }
  end
end