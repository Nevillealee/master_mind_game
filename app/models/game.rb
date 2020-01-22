class Game < ApplicationRecord
  has_many :feedbacks
  belongs_to :user

  def compare_answer(guess)
    puts "compare answer recieved: #{guess}"
    if guess == number_combo
      won = true
      return "You guessed the number!!!"
    elsif num_match_position?(guess)
      return "You guessed a correct digit and its correct location!"
    elsif contains_num?(guess)
      return "You guessed a correct digit"
    end
  end

  private

  def contains_num?(guess_num)
    guess_num.split('').each do |d|
      return true if number_combo.include?(d)
    end
    return false
  end

  def num_match_position?(guess_num)
    guess_num.split('').each_with_index do |d, index|
      return true if number_combo[index] == d
    end
    return false
  end
end
