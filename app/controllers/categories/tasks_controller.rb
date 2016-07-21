class Categories::TasksController < ApplicationController
  before_action :set_category
  before_action :set_categories
  before_action :set_new_task
  before_action :set_search

  def index
    @tasks = @category.tasks.doings.sort_by(&:least_time_per)
    render "tasks/filter"
  end

  private

  def set_category
    @category = Category.on_user.find(params[:category_id])
  end

  def set_new_task
    @task = @category.tasks.new
  end
end