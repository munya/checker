class AddColumnApIdToOperations < ActiveRecord::Migration
  def change
    add_column :operations, :ap_id, :string
  end
end
