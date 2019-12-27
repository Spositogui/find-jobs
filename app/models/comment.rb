class Comment < ApplicationRecord
  belongs_to :candidate
  belongs_to :head_hunter
  validates :message, presence: true
end
