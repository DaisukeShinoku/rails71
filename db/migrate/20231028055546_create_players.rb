class CreatePlayers < ActiveRecord::Migration[7.1]
  def change
    create_table :players do |t|
      t.references :team, null: false, foreign_key: true
      t.string :name, null: false, limit: 50
      t.integer :gender, null: false, limit: 1, default: 0
      t.timestamps
    end
  end
end
