class TasksController < ApplicationController
  include TasksAction
  before_action :set_task, only: [:update, :destroy, :done, :undo]
  before_action :set_new_task, only: [:index, :completed, :today, :weekly]
  before_action :set_search, only: [:index, :completed, :today, :weekly]

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

  def new
    @task = Task.new
  end

  # TODO
  # jQuery ajax で何をもらうかちゃんと考えんとですよ
  def done
    @task.done
    @tasks = Task.on_user.doings
    render json: {
      task:  @task.to_json,
      counts: {
        tasks: @tasks.count,
        today: @tasks.todays.count,
        weekly: @tasks.weeklys.count
      }
    }
  end

  # render js
  def undo
    @task.undo
    @tasks = Task.on_user.doings
    render json: {
      task:  @task.to_json,
      counts: {
        tasks: @tasks.count,
        today: @tasks.todays.count,
        weekly: @tasks.weeklys.count
      }
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

  def set_task
    @task = Task.on_user.find_by(id: params[:id])
  end

  def set_new_task
    @task = Task.new
  end

  def set_search
    @search = Task.search(params[:q])
  end
end
