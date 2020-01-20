class Game < ApplicationRecord
  has_many :feedbacks
  has_many :users, through: :feedbacks
end
