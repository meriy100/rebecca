class CategoriesController < ApplicationController
  before_action :set_category, only: [:update, :destroy]
  before_action :set_categories, only: [:index]
  before_action :set_new_category, only: [:index]

  def index
    @tasks = @search.result.on_user.doings.where(category_id: params[:q]).sort_by(&:least_time_per)
    render :filter
  end

  def create
    @category = Category.new(category_params)
    @category.save
    redirect_to tasks_path
  end

  private

  def set_category
    @category = Category.on_user.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :row_order, :user_id, :color_id, :sync_token, :icon_id, :created_at, :updated_at)
  end
end
