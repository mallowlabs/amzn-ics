class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :user_id
      t.string :asin
      t.string :title
      t.string :thumb_url
      t.datetime :release_date

      t.timestamps null: false
    end

    add_index :items, :release_date, unique: false
  end
end
