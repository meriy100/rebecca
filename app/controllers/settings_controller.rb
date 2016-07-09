class SettingsController < ApplicationController
  before_action :set_setting, only: [:show, :update]
  def show
    @task = Task.new
    @search = Task.search(params[:q])
    @filter = { title: "タスク一覧", path: tasks_path }
    @google_accounts = current_user.google_accounts
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
    client = OathOtherService::GoogleCalendar.client_on_code(params[:code])
    response = client.fetch_access_token!
    google_account = current_user.google_accounts.create(access_token: response['access_token'], refresh_token: response["refresh_token"], expires_in: response["expires_in"])
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client
    calendar_hashs = service.list_calendar_lists.items.map do |item|
      {
        calendar_id: item.id,
        summary: item.summary
      }
    end
    google_account.google_calendars.create(calendar_hashs)
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
