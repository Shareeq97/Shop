class Comment < ApplicationRecord
  belongs_to :feature
  belongs_to :user
end

