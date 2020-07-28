class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.references :category,    null: false, foreign_key: true
      t.references :user,        null: false, foreign_key: true
      t.string     :post_name,   null: false, limit: 150
      t.text       :description, null: false
      t.string     :image
      t.timestamps
    end
  end
end
