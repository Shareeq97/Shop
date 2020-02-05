class Document < ApplicationRecord

  belongs_to :feature

  attr_accessor :document
	has_attached_file :document
	validates_attachment :document, content_type: { content_type: %w(image/jpeg image/jpg image/png application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document application/vnd.ms-excel application/vnd.openxmlformats-officedocument.spreadsheetml.sheet application/x-ole-storage) }
end

