class CopyProductPriceToLineItem < ActiveRecord::Migration
  def up
    # Add price column to line item table
    add_column :line_items, :price, :decimal, precision: 8, scale: 2
    # Iterate over existing line items
    LineItem.all.each do |item|
      # Get price from related product and update attribute
      item.update_attribute :price, Product.find(item.product_id).price
    end
  end

  def down
    remove_column :line_items, :price
  end
end
