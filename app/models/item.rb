class Item < ApplicationRecord
  belongs_to :user
  has_one :order
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_charge
  belongs_to :delivery_area
  belongs_to :delivery_day

  with_options presence: true do
    validates :name
    validates :description
    validates :price
    validates :image
  end

  with_options numericality: { other_than: 1, message: 'を選択してください' } do
    validates :category_id
    validates :condition_id
    validates :delivery_charge_id
    validates :delivery_area_id
    validates :delivery_day_id
  end

  validates :price, numericality: { with: /\A[0-9]+\z/, message: 'は半角数字を使用してください' }
  validates :price,
            numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                            message: 'は¥300~¥9,999,999の間で入力してください' }
end
