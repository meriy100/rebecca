class TasksController < ApplicationController
  include TasksAction
  before_action :set_task, only: [:update, :destroy, :done, :undo]
  before_action :set_new_task, only: [:index, :completed, :today, :weekly]

  def index
    @filter = { title: "タスク一覧", path: tasks_path }
    @search = Task.on_user.doings.search(params[:q])
    @tasks = @search.result.sort_by(&:least_time_per)
  end

  # get
  def completed
    @filter = { title: "終了済みのタスク", path: completed_tasks_path }
    @search = Task.on_user.completeds.search(params[:q])
    @tasks = @search.result.sort_by(&:least_time_per)
  end

  def today
    @filter = { title: "今日のタスク", path: today_tasks_path }
    @search = Task.on_user.doings.todays.search(params[:q])
    @tasks = @search.result.sort_by(&:least_time_per)
    render 'filter'
  end

  def weekly
    @filter = { title: "今週のタスク", path: weekly_tasks_path }
    @search = Task.on_user.doings.weeklys.search(params[:q])
    @tasks = @search.result.sort_by(&:least_time_per)
    render 'filter'
  end

  def new
    @task = Task.new
  end

  # TODO
  # jQuery ajax で何をもらうかちゃんと考えんとですよ
  def done
    @task.done
    render json: @task.to_json
  end

  def undo
    @task.undo
    render json: @task.to_json
  end

  def create
    @task = Task.new(task_params)
    render :new unless @task.save
  end

  def update
    if @task.update(params[:atr] => params[:value])
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

end
