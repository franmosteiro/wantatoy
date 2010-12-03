class CreateToys < ActiveRecord::Migration
  def self.up
    create_table :toys do |t|
      t.string :title
      t.text :description
      t.string :contact
      t.timestamps
    end
  end

  def self.down
    drop_table :toys
  end
end
