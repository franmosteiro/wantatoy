class AddThumbToToy < ActiveRecord::Migration
  def self.up
        add_column :toys, :thumb_file_name,    :string
        add_column :toys, :thumb_content_type, :string
        add_column :toys, :thumb_file_size,    :integer
        add_column :toys, :thumb_updated_at,   :datetime
  end

  def self.down
        remove_column :toys, :thumb_file_name
        remove_column :toys, :thumb_content_type
        remove_column :toys, :thumb_file_size
        remove_column :toys, :thumb_updated_at
  end
end
