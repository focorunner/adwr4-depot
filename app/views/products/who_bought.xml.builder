xml.instruct!
xml.feed do
  xml.title "Who bought #{@product.title}"

  xml.updated @latest_order.try(:updated_at) 

  @product.orders.each do |order|
    xml.entry do |entry|
      entry.title "Order #{order.id}"
      entry.url "#{order_url(order_id: order.id)}"
      entry.date order.updated_at
      entry.summary do |xml|
        xml.ship_to "#{order.address}"
        xml.products do
          order.line_items.each do |item|
            xml.title item.product.title
            xml.quantity item.quantity
            xml.item_total number_to_currency item.total_price
          end
        end
        xml.payment do
          xml.order_total number_to_currency order.line_items.map(&:total_price).sum
          xml.paid_by "#{order.pay_type}"
        end
      end
      xml.customer do
        xml.name order.name
        xml.email order.email
      end
    end
  end
end