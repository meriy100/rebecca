class SettingsController < ApplicationController
  def show
    current_user.setting
    @task = Task.new
    @search = Task.search(params[:q])
    @filter = { title: "タスク一覧", path: tasks_path }
  end
  def update
  end
  private
end
