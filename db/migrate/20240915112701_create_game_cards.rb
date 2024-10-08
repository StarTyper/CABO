class CreateGameCards < ActiveRecord::Migration[7.1]
  def change
    create_table :game_cards do |t|
      t.references :card, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
