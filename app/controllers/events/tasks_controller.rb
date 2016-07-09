class Event::TasksController < ApplicationController
  include TasksAction
  before_action :set_task, only: [:update, :destroy, :done, :undo]
  before_action :set_new_task, only: [:index, :completed, :today, :weekly]
  before_action :set_search, only: [:index, :completed, :today, :weekly]

  def index
    @tasks = @search.result.on_user.doings.sort_by(&:least_time_per)
  end

  private

  def set_new_task
    @task = Task.new
  end

  def set_search
    @search = Task.search(params[:q])
  end
end
