class SettingsController < ApplicationController
  before_action :set_setting, only: [:show, :update]
  def show
    @task = Task.new
    @search = Task.search(params[:q])
    @filter = { title: "タスク一覧", path: tasks_path }
  end

  def update
    @setting.update(setting_params)
    render json: :setting
  end

  private

  def set_setting
    @setting = current_user.setting
  end

  def setting_params
    params.require(:setting).permit(:start_week_day_id, :time_format_id)
  end
end
