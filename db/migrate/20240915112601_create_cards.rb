class CreateCards < ActiveRecord::Migration[7.1]
  def change
    create_table :cards do |t|
      t.integer :number
      t.string :specialty
      t.text :image_url

      t.timestamps
    end
  end
end
