class AddPriceToLineItems < ActiveRecord::Migration[8.0]
  def change
    add_column :line_items, :price, :decimal
    LineItem.all.each do |li|
      li.price = li.product.price
      li.save!
    end
  end
end