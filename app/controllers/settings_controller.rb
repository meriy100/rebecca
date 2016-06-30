class SettingsController < ApplicationController
  def show
    @setting = current_user.setting || Setting.new(start_week_day_id: 2)
    @task = Task.new
    @search = Task.search(params[:q])
    @filter = { title: "タスク一覧", path: tasks_path }
  end
  def update
  end
  private
end
