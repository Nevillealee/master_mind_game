class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.belongs_to :user
      t.integer :attempts_remaining, default: 10
      t.string :number_combo
      t.boolean :won, default: false
      t.integer :difficulty
      t.integer :score
      t.timestamps
    end
  end
end
