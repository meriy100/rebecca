class SettingsController < ApplicationController
  before_action :set_setting, only: [:show, :update]
  def show
    @task = Task.new
    @search = Task.search(params[:q])
    @filter = { title: "タスク一覧", path: tasks_path }
    if current_user.setting.google_token
      # @calendar_list = OathOtherService::GoogleCalendar.calendar_list(current_user.setting.google_token)
    end
  end
  # 4/DXokFdX68ztB8InKxenf2zw0aDNb9W8mqBA-1SwHHWY
  def update
    @setting.update(setting_params)
    render json: :setting
  end

  def oath
    redirect_to "OathOtherService::#{params[:oath_name].camelize}".constantize.oath_path
  end

  def google_callback
    client = OathOtherService::GoogleCalendar.client(params[:code])
    response = client.fetch_access_token!
    current_user.setting.update google_token: response['access_token']
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    @calendar_list = service.list_calendar_lists
    redirect_to setting_path
  end

  private

  def set_setting
    @setting = current_user.setting
  end

  def setting_params
    params.require(:setting).permit(:start_week_day_id, :time_format_id)
  end
end
