module Georgia
  class MediaPolicy < ApplicationPolicy

    def index?
      media_user_permissions(:show_media_assets).include?(true)
    end

    def show?
      edit?
    end

    def new?
      create?
    end

    def create?
      media_user_permissions(:upload_media_assets).include?(true)
    end

    def edit?
      update?
    end

    def update?
      media_user_permissions(:update_media_assets).include?(true)
    end

    def destroy?
      media_user_permissions(:delete_media_assets).include?(true)
    end

    def download?
      media_user_permissions(:download_media_assets).include?(true)
    end

    # API calls

    def pictures?
      index?
    end

    private

    def media_permissions
      Georgia.permissions[:media_library]
    end

    def media_user_permissions action
      user_permissions(media_permissions, action)
    end
  end
end