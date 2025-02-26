class AddQuantityToLineItems < ActiveRecord::Migration[8.0]
  def change
    add_column :line_items, :quantity, :integer
  end
end
