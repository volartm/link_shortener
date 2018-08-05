class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
      t.string :link
      t.string :link_hash

      t.timestamps
    end
    add_index :links, :link
    add_index :links, :link_hash
  end
end
