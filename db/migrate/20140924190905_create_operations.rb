class CreateOperations < ActiveRecord::Migration
  def change
    create_table :operations do |t|
      t.string :function_name

      t.timestamps
    end
  end
end
