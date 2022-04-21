class Api::V1::OrderMenusController < ApplicationController
  before_action :set_order_menu, only: %i[ show update destroy ]

  # GET /order_menus
  def index
    @order_menus = OrderMenu.all

    render json: @order_menus
  end

  # GET /order_menus/1
  def show
    render json: @order_menu
  end

  # POST /order_menus
  def create
    new_params = order_menu_params
    menu_id = Menu.find_id(order_menu_params[:menu_id])
    new_params[:order_id] = order_menu_params[:order_id]
    new_params[:menu_id] = menu_id[0]
    new_params[:quantity] = order_menu_params[:quantity]
    @order_menu = OrderMenu.new(new_params)

    if @order_menu.save
      @check_order_price = Order.find_price(order_menu_params[:order_id])
      @chek_menu_price = Menu.find_price(order_menu_params[:menu_id])

      @current_price = @chek_menu_price[0] * order_menu_params[:quantity].to_f
      @result_price = @check_order_price[0] + @current_price

      @update_order_menu = OrderMenu.find(@order_menu.id)
      @update_order_menu.update_column(:total_price, @current_price)

      @update_order = Order.find(order_menu_params[:order_id])
      @update_order.update_column(:total_price, @result_price)

      @final_order = Order.find(order_menu_params[:order_id])

      render json: @final_order, status: :created
    else
      render json: @order_menu.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /order_menus/1
  def update
    if @order_menu.update(order_menu_params)
      render json: @order_menu
    else
      render json: @order_menu.errors, status: :unprocessable_entity
    end
  end

  # DELETE /order_menus/1
  def destroy
    @order_menu.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_menu
      @order_menu = OrderMenu.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_menu_params
      params.require(:order_menu).permit(:order_id, :menu_id, :quantity)
    end
end
