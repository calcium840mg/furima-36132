require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'user登録' do
    before do
      @item = FactoryBot.build(:item)
      sleep(1)
    end
    
    context '正常系' do
      it '登録できる' do
        expect(@item).to be_valid
      end
    end

    context '異常系' do
      it '画像が選択されている' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名が記載されている' do
        @item.product_name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Product name can't be blank")
      end

      it '商品の説明が記載されている' do
        @item.info = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Info can't be blank")
      end

      it 'カテゴリーのid:1を選択した時' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it '商品の状態のid:1を選択した時' do
        @item.sales_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Sales status can't be blank")
      end

      it '配送料の負担のid:1を選択した時' do
        @item.shipping_fee_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee status can't be blank")
      end

      it '発送元の地域のid:1を選択した時' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '発送までの日数のid:1を選択した時' do
        @item.scheduled_delivery_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Scheduled delivery can't be blank")
      end

      it '価格が記載されていない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it '価格を全角で記載した時' do
        @item.price = "５００"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is invalid. Input half-width characters")
      end

      it '価格を299円以下で記載した時' do
        @item.price = 130
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is out of setting range")
      end

      it '価格を1000万以上で記載した時' do
        @item.price = 9999999999
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is out of setting range")
      end

      it '価格に半角英数字混合で記載した時' do
        @item.price = '50000yen'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is invalid. Input half-width characters')
      end

      it '価格に半角英字のみで記載した時' do
        @item.price = 'yen'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is invalid. Input half-width characters')
      end

    end
  end
end