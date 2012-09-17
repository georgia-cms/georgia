module Georgia
	class Message < ActiveRecord::Base

		attr_accessible :name, :email, :subject, :message

		validates :name, presence: true
		validates :email, presence: true, format: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
		validates :message, presence: true

	end
end