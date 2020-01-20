class User < ApplicationRecord
  has_many :feedbacks
  has_many :games, through: :feedbacks
end
