class Feedback < ApplicationRecord
  belongs_to :game
  belongs_to :user, counter_cache: true
end
