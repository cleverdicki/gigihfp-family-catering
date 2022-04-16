class OrderMenusController < ApplicationController
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
    @order_menu = OrderMenu.new(order_menu_params)

    if @order_menu.save
      render json: @order_menu, status: :created, location: @order_menu
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
      params.require(:order_menu).permit(:order_id, :menu_id, :quantity, :total_price)
    end
end
