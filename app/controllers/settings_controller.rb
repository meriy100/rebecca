class SettingsController < ApplicationController
  before_action :set_setting, only: [:show, :update]
  def show
    @task = Task.new
    @search = Task.search(params[:q])
    @filter = { title: "タスク一覧", path: tasks_path }
  end
  def update
    @setting.update(setting_params[:attr] => setting_params[:value])
    render json: :setting
  end
  private
  def set_setting
    @setting = current_user.setting
  end
  def setting_params
    params.require(:setting).permit(:attr, :value)
  end
end
