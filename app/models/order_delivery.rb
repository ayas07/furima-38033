class OrderDelivery
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :delivery_area_id, :city, :address, :building, :phone_number, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'はハイフン(-)を含めて半角で入力してください' }
    validates :city
    validates :address
    validates :phone_number, length: { in: 10..11 },
                             numericality: { only_integer: true, with: /\A[0-9]+\z/, message: 'は半角数字を使用してください' }
    validates :token
  end
  validates :delivery_area_id, numericality: { other_than: 1, message: 'を選択してください' }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Delivery.create(post_code: post_code, delivery_area_id: delivery_area_id, city: city, address: address, building: building,
                    phone_number: phone_number, order_id: order.id)
  end
end
