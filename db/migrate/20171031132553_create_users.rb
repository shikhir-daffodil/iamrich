class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :fbid, limit: 50
      t.boolean :fblogin
      t.string :first_name, limit: 30
      t.string :last_name, limit: 30
      t.string :gender, limit: 10
      t.string :locale, limit: 7
      t.text :picture_url
      t.integer :coins, limit: 5

      t.timestamps
      t.index [:fbid], unique: true
    end
  end
end
