class TasksController < ApplicationController
  include TasksAction
  before_action :set_task, only: [:update, :destroy, :done]

  def index
    @filter = {title: "タスク一覧", path: tasks_path}
    @search = Task.on_user.where(is_done:false).search(params[:q])
    @tasks = @search.result.sort_by(&:least_time_per)
  end

  # get
  def completed
    @filter = {title: "終了済みのタスク", path: completed_tasks_path}
    @search = Task.on_user.where(is_done: true).search(params[:q])
    @tasks = @search.result.sort_by(&:least_time_per)
    render 'filter'
  end

  def today
    @filter = {title: "今日のタスク", path: today_tasks_path}
    @search = Task.on_user.where(deadline_at: Time.zone.today..Time.zone.tomorrow, is_done: false).search(params[:q])
    @tasks = @search.result.sort_by(&:least_time_per)
    render 'filter'
  end

  def weekly
    @filter = {title: "今週のタスク", path: weekly_tasks_path}
    @search = Task.on_user.where(deadline_at: Time.zone.today.beginning_of_week..Time.zone.today.end_of_week, is_done: false).search(params[:q])
    @tasks = @search.result.sort_by(&:least_time_per)
    render 'filter'
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
