class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :user,          null: false, foreign_key: true
      t.references :post,          null: false, foreign_key: true
      t.string     :comment_title, null: false, limit: 255
      t.text       :comment_body,  null: false

      t.timestamps
    end
  end
end
