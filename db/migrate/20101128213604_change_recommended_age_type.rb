class ChangeRecommendedAgeType < ActiveRecord::Migration
  def self.up
    remove_column :toys, :recommended_age
    add_column :toys, :recommended_age, :string
  end

  def self.down
    remove_column :toys, :recommended_age
  end
end
