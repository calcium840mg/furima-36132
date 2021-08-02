class PurchaseAddressController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_item
  before_action :root_purchases

  
  
  def new
    @purchase_address = PurchaseAddress.new
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_params)
    if  @purchase_address.valid?
      pay_item
      @purchase_address.save
      redirect_to root_path
    else
      render :new   
    end
  end

    private

    def purchase_params
    params.require(:purchase_address).permit(:postal_code, :prefecture_id, :city, :building, :addresses, :phone_number ).merge( user_id: current_user.id, item_id: @item.id, token: params[:token])
    end

    def pay_item
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(  
        amount: @item.price,            
        card: params[:token],  
        currency: 'jpy'                 
          ) 
    end

    def root_purchases
      if current_user.id == @item.user_id || @item.purchase.present?
      redirect_to root_path
      end
    end  
  
    def set_item
      @item = Item.find(params[:item_id])
    end

  end
