class Api::V1::MenuCategoriesController < ApplicationController
  before_action :set_menu_category, only: %i[ show update destroy ]

  # GET /menu_categories
  def index
    @menu_categories = MenuCategory.all

    render json: @menu_categories
  end

  # GET /menu_categories/1
  def show
    render json: @menu_category
  end

  # POST /menu_categories
  def create
    @menu_category = MenuCategory.new(menu_category_params)

    if @menu_category.save
      render json: @menu_category, status: :created
    else
      render json: @menu_category.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /menu_categories/1
  def update
    if @menu_category.update(menu_category_params)
      render json: @menu_category
    else
      render json: @menu_category.errors, status: :unprocessable_entity
    end
  end

  # DELETE /menu_categories/1
  def destroy
    @menu_category.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu_category
      @menu_category = MenuCategory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def menu_category_params
      params.require(:menu_category).permit(:menu_id, :category_id)
    end
end