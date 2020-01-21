class CreateFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :feedbacks do |t|
      t.belongs_to :game
      t.integer :attempt
      t.string :result
      t.string :user_guess
      t.timestamps
    end
  end
end
