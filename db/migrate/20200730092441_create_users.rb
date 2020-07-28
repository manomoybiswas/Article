class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string  :name,           null: false, limit: 30
      t.string  :email,          null: false, limit: 30
      t.string  :mobile,         null: false, limit: 14
      t.boolean :admin,          default: false
      t.string  :avater
      t.string  :password_digest, null: false

      t.timestamps
    end
  end
end
