class Project < ApplicationRecord
  validates :project_name, presence: true
  validates_uniqueness_of :project_name, scope: :user_id, case_sensitive: false

	belongs_to :user
	has_many :features, dependent: :destroy
end
