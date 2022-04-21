class Api::V1::OrdersController < ApplicationController
  before_action :set_order, only: %i[ show update destroy ]

  # GET /orders
  def index
    if filter_params["filter_name"] == "daily"
      @orders = Order.daily_report
    else
      @orders = Order.all
    end

    render json: @orders, :include => :order_menus
  end

  # GET /orders/1
  def show
    render json: @order
  end

  # POST /orders
  def create
    @order = Order.new(order_params)
    @order.menus << Menu.find(Menu.find_id(menu_params["menu_name"]))

    if @order.save
      @chek_price = Menu.find_price(menu_params["menu_name"])
      
      @result_price = @chek_price[0] * menu_params["quantity"].to_f
      
      @order_menu = OrderMenu.find_by(order_id: @order.id)
      @order_menu.update_column(:quantity, menu_params["quantity"])
      @order_menu.update_column(:total_price, @result_price)
      
      @main_order = Order.find(@order.id)
      @main_order.update_column(:total_price, @result_price)
      
      @final_order = Order.find(@order.id)

      render json: @final_order, status: :created, :include => :order_menus
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /orders/1
  def update
    if @order.update(update_order_params)
      render json: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # DELETE /orders/1
  def destroy
    @order.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:customer_name, :customer_email)
    end
  
    def update_order_params
      params.require(:update_order).permit(:customer_name, :customer_email, :status)
    end

    def menu_params
      params.require(:menu).permit(:menu_name, :quantity)
    end

    def filter_params
      params.require(:filter).permit(:filter_name)
    end
end
