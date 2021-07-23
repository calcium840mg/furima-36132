FactoryBot.define do
  factory :item do
    
    product_name { "オアシス" }
    info { "スーパーソニック" }
    category_id { 5 }
    sales_status_id { 5 }
    shipping_fee_status_id { 5 }
    prefecture_id { 5 }
    scheduled_delivery_id { 5 }
    price { 50000 }
    association :user
  

  after(:build) do |item|
    item.image.attach(io: File.open('public/test.png'), filename: 'test.png' , content_type: 'image/png')
  end
end

end
