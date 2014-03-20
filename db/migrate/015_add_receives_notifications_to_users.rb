class AddReceivesNotificationsToUsers < ActiveRecord::Migration

  def change
    add_column :georgia_users, :receives_notifications, :boolean, default: true
  end

end