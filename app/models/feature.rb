class Feature < ApplicationRecord
 	before_create :assign_unique_ticket_id

  validates :feature_name, presence: true, uniqueness: { scope: :project_id }

  validates! :ticket_id, uniqueness: true
  
	belongs_to :project
	has_many :tasks, dependent: :destroy
	has_many :comments, dependent: :destroy 
	has_many :documents, dependent: :destroy
	has_many :notifications, dependent: :destroy
	belongs_to :user, optional: true	

	private
		TICKET_ID_RANGE = (10_00_000..99_99_999)
		def assign_unique_ticket_id
		  self.ticket_id = loop do
		    number = rand(TICKET_ID_RANGE)
		    break number unless Feature.exists?(ticket_id: number)
		  end
		end
end
