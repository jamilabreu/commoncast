class CreateCommunities < ActiveRecord::Migration
  def change
    create_table :communities do |t|
      t.string :name
      t.string :filter_name
      t.string :title_name
      t.string :slug
      t.text :description
      t.string :type

      t.timestamps
    end
  end
end
