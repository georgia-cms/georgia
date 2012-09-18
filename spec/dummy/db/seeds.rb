# encoding: UTF-8
# Create an admin user to start playing around
Georgia::User.create(first_name: 'Mathieu', last_name: 'Gagne', email: 'mathieu@motioneleven.com', password: 'motion11', password_confirmation: 'motion11') do |user|
  user.roles << Georgia::Role.create(name: 'Admin')
  user.roles << Georgia::Role.create(name: 'Editor')
end