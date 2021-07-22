class Item < ApplicationRecord
  belongs_to :user
  has_one    :purchase
  has_one_attached :image

  with_options presence: true do
    validates :image
    validates :user
    validates :product_name
    validates :info
    validates :category_id
    validates :sales_status_id
    validates :shipping_fee_status_id
    validates :prefecture_id
    validates :scheduled_delivery_id
    validates :price, numericality: { only_integer: true, message: 'is invalid. Input half-width characters' },
    inclusion: { in: 300..9_999_999, message: 'is out of setting range' }, format: { with: /\A[0-9]+\z/ }
  end

  with_options numericality: {other_than: 1, message: "can't be blank"} do
    
    validates :category_id
    validates :sales_status_id
    validates :shipping_fee_status_id
    validates :prefecture_id
    validates :scheduled_delivery_id
    
  end



  
  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to :category
    belongs_to :sales_status
    belongs_to :shipping_fee_status
    belongs_to :prefecture
    belongs_to :scheduled_delivery

end
