# encoding: UTF-8
class CreateRatings < ActiveRecord::Migration
  def self.up
    create_table(:ratings) do |t|
      t.column :ratetor_id, :integer, :null => false
      t.column :ratetor_type, :string, :null => false
      t.column :rate, :float, :null => false
      t.column :rateable_id, :integer, :null => false
      t.column :rateable_type, :string

      t.timestamps
    end

    add_index :ratings, [:rateable_id, :rateable_type]
  end

  def self.down
    drop_table :ratings
  end
end
