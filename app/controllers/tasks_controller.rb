class TasksController < ApplicationController
  include TasksAction
  before_action :set_task, only: [:update, :destroy, :done]

  def index
    @search = Task.search(params[:q])
    @tasks = @search.result.on_user.where(is_done: false).sort_by(&:least_time_per)
  end

  # get
  def doned
    @search = Task.where(is_done: true).search(params[:q])
    @tasks = @search.result.on_user.sort_by(&:least_time_per)
  end

  def new
    @task = Task.new
  end

  # TODO
  # jQuery ajax で何をもらうかちゃんと考えんとですよ
  def done
    if @task.done
      head 200
    else
      head 300
    end
  end

  def create
    @task = Task.new(task_params)
    render :new unless @task.save
  end

  def update
    @task.update(params[:atr] => params[:value])
    head 200
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
end
