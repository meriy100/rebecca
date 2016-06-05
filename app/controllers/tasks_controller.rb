class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :done]

  def index
    @search = Task.search(params[:q])
    @tasks = @search.result.where(user: current_user, is_done: false).sort_by{|task| task.least_time_per}
  end

  # post
  def doned
    @tasks = Task.where(user: current_user, is_done: true)
  end

  def new
    @task = Task.new
  end

  # TODO jQuery ajax で何をもらうかちゃんと考えんとですよ
  def done
    if @task.done
      head 200
    else
      head 300
    end
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      @tasks = Task.where(user: current_user, is_done: false).sort_by{|task| task.least_time_per}
    else
      render :new
    end
  end

  def update
    @task.update(params["atr"] => params["value"])
    head  200
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_task
      @task = Task.where(user: current_user).find(params[:id])
    end

    def task_params
      params.require(:task).permit(:user_id, :title, :is_done, :weight, :deadline_at, :deleted_at)
    end
end
