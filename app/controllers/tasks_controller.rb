class TasksController < ApplicationController
  include TasksAction
  before_action :set_events, only: [:index, :completed, :today, :weekly]
  before_action :set_task, only: [:update, :destroy, :done, :undo]
  before_action :set_new_task, only: [:index, :completed, :today, :weekly]
  before_action :set_search, only: [:index, :completed, :today, :weekly]
  before_action :check_events, only: :index
  before_action :set_new_category, only: [:index, :completed, :today, :weekly]
  before_action :set_colors, only: [:index, :completed, :today, :weekly]
  before_action :set_icons, only: [:index, :completed, :today, :weekly]

  def index
    @tasks = @search.result.on_user.doings.sort_by(&:least_time_per)
  end

  def completed
    @completed_tasks = @search.result.on_user.completeds.sort_by(&:least_time_per)
  end

  def today
    @tasks = @search.result.on_user.doings.todays.sort_by(&:least_time_per)
    render :filter
  end

  def weekly
    @tasks = @search.result.on_user.doings.weeklys.sort_by(&:least_time_per)
    render :filter
  end

  # TODO
  # createの際のエラー対処
  def import
    tasks_imported = "Importer::#{service_params[:service_name].capitalize}".constantize.import(service_params[:token])
    tasks = Task.create(tasks_imported)
    render json: { message:  "#{tasks.count}件のタスクが同期されました" }
  end

  def new
    @task = Task.new
  end

  # TODO
  # jQuery ajax で何をもらうかちゃんと考えんとですよ
  def done
    @task.done
    @tasks = Task.on_user.doings
    render json: {
      task:  @task,
      counts: Task.doing_counts
    }
  end

  # render js
  def undo
    @task.undo
    @tasks = Task.on_user.doings
    render json: {
      task:  @task,
      counts: Task.doing_counts
    }
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      @tasks = Task.on_user.doings
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      render json: @task.to_json, status: 200
    else
      render json: @task.to_json, status: 501
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def service_params
    params.require(:service).permit(:service_name, :token)
  end

  def set_task
    @task = Task.on_user.find_by(id: params[:id])
  end

  def set_new_category
    @category = Category.new
  end

  def set_colors
    @colors = CategoryColor.all
  end

  def set_icons
    @icons = CategoryIcon.all
  end
end
