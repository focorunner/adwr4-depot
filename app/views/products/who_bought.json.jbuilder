json.instruct!
json.feed do
  json.title "Who bought #{@product.title}"

  json.updated @latest_order.try(:updated_at) 

  json.entry @product.orders do |order|
    json.title "Order #{order.id}"
    json.url "#{order_url(order_id: order.id)}"
    json.date order.updated_at
    json.summary do |json|
      json.ship_to "#{order.address}"
      json.products do
        order.line_items.each do |item|
          json.title item.product.title
          json.quantity item.quantity
          json.item_total number_to_currency item.total_price
        end
      end
      json.payment do
        json.order_total number_to_currency order.line_items.map(&:total_price).sum
        json.paid_by "#{order.pay_type}"
      end
    end
    json.customer do
      json.name order.name
      json.email order.email
    end
  end
end