class CategoriesController < ApplicationController
  before_action :set_category, only: [:update, :destroy]

  def create
    @category = Category.new(category_params)
    @category.save
    render nothing: true
  end

  private

  def set_category
    @category = Category.on_user.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :row_order, :user_id, :color_id, :sync_token, :icon_id, :created_at, :updated_at)
  end
end
