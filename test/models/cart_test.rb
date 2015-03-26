require 'test_helper'

class CartTest < ActiveSupport::TestCase
  test "add unique products" do
    cart = Cart.create
    product_one = products(:one)
    product_two = products(:two)
    cart.add_product(product_one.id).save!
    cart.add_product(product_two.id).save!
    assert_equal 2, cart.line_items.size
    assert_equal product_one.price + product_two.price, cart.total_price
  end  

  test "add duplicate products" do
    cart = Cart.create
    product = products(:ruby)
    cart.add_product(product.id).save!
    cart.add_product(product.id).save!
    assert_equal 2 * product.price, cart.total_price, "total price icorrect"
    assert_equal 1, cart.line_items.size, "line item # incorrect"
    assert_equal 2, cart.line_items.sum(:quantity), "final quantity is incorrect"
  end
end
