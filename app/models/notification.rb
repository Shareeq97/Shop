class Notification < ApplicationRecord

	after_commit -> { NotificationRelayJob.perform_later(self) }
	  
  belongs_to :user
  belongs_to :feature
	belongs_to :recipient, class_name: "User"

end
