class ProductPricesController < ApplicationController
  before_action :set_customer
  before_action :set_product_price, only: [:edit, :update, :destroy]

  def index
    @product_prices = @customer.product_prices.includes(:product)
  end

  def new
    @product_price = @customer.product_prices.build
  end

  def create
    @product_price = @customer.product_prices.build(product_price_params)
    
    if @product_price.save
      redirect_to customer_product_prices_path(@customer), notice: "商品単価を登録しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @product_price.update(product_price_params)
      redirect_to customer_product_prices_path(@customer), notice: "商品単価を更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product_price.destroy
    redirect_to customer_product_prices_path(@customer), notice: "商品単価を削除しました。"
  end

  private

  def set_customer
    @customer = Customer.find(params[:customer_id])
  end

  def set_product_price
    @product_price = @customer.product_prices.find(params[:id])
  end

  def product_price_params
    params.require(:product_price).permit(:product_id, :selling_price, :notes)
  end
end
