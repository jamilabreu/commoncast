class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.text :url
      t.boolean :approved, null: false, default: false
      t.string :type
      t.references :user, index: true

      t.timestamps
    end
  end
end
