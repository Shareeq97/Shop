class Task < ApplicationRecord
	validates :task_name, presence: true, :uniqueness => {:scope => :feature_id}
	
	belongs_to :feature
end
