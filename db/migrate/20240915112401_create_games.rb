class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :player_count
      t.string :name
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end
end
