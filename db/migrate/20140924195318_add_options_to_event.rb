class AddOptionsToEvent < ActiveRecord::Migration
  def change
    add_column :events, :options, :hstore
  end
end
