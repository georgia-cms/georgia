# encoding: UTF-8
# Create an admin user to start playing around
Georgia::User.create(first_name: 'Mathieu', last_name: 'Gagne', email: 'mathieu@motioneleven.com', password: 'motion11', password_confirmation: 'motion11') do |user|
  user.roles << Georgia::Role.create(name: 'Admin')
  user.roles << Georgia::Role.create(name: 'Editor')
end

Georgia::Status.create(name: 'Published', label: 'success', icon: 'icon-eye-open')
Georgia::Status.create(name: 'Pending Review', label: 'warning', icon: 'icon-time')
Georgia::Status.create(name: 'Draft', label: 'error', icon: 'icon-eye-close')
Georgia::Status.create(name: 'Incomplete', label: 'info', icon: 'icon-exclamation-sign')