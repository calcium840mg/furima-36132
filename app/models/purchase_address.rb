class PurchaseAddress < ApplicationRecord
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "はハイフン(-)を入れて入力してください"}
    validates :prefecture_id, numericality: { other_than: 0,  message: "を入力してください"}
    validates :city
    validates :addresses
    validates :phone_number, format: {with: /\A\d{10,11}\z/}
    validates :user_id
    validates :item_id
    validates :token
  end

  def save
    @purchase = Purchase.create(user_id: user_id, item_id: item_id )
    Address.create(building: building, postal_code: postal_code, prefecture_id: prefecture_id, city: city, addresses: addresses, phone_number: phone_number, purchase_id: @purchase.id)
  end

end
