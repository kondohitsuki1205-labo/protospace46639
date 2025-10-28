class Comment < ApplicationRecord
  validates :text, :content, presence: true
  belongs_to :user
  belongs_to :prototype

end