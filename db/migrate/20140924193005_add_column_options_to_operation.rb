class AddColumnOptionsToOperation < ActiveRecord::Migration
  def change
    add_column :operations, :options, :hstore
  end
end
