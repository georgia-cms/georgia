Georgia::Role.destroy_all
Georgia::Role.create(name: 'Admin')

Georgia::User.destroy_all
mathieu = Georgia::User.create(email: 'mathieu@motioneleven.com', password: 'motion11', password_confirmation: 'motion11')
mathieu.roles << Georgia::Role.find_by_name('Admin')
mathieu.save!