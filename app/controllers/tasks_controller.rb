# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  name        :string(255)
#  status      :integer
#  deadline_at :datetime
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :done]

  def index
    @tasks = Task.where(user: current_user, status: Task::DOING)
  end

  def doned
    @tasks = Task.where(user: current_user, status: Task::DONE)
  end

  def trushed
    @tasks = Task.where(user: current_user, status: Task::TRUSH)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def done
    if @task.done
      redirect_to tasks_path
    else
      redirect_to tasks_path
    end
  end

  def create
    @task = Task.new(task_params)
    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :index, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :index, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
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
      params.require(:task).permit(:user_id, :name, :deadline_at, :deleted_at)
    end
end
