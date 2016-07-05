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

  def oath
    redirect_to "OathOtherService::#{params[:oath_name].camelize}".constantize.oath_path
  end

  def callback
    client = Signet::OAuth2::Client.new({
        client_id: ENV.fetch('GOOGLE_API_CLIENT_ID'),
        client_secret: ENV.fetch('GOOGLE_API_CLIENT_SECRET'),
        token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
        redirect_uri: url_for(action: "callback"),
        code: params[:code]
      })

    response = client.fetch_access_token!

    session[:access_token] = response['access_token']
    # client = Signet::OAuth2::Client.new(access_token: session[:access_token])

    service = Google::Apis::CalendarV3::CalendarService.new

    service.authorization = client

    @calendar_list = service.list_calendar_lists
    events = service.list_events(@calendar_list.items.first.id).items

    task_list = events.map do |event|
      {
        title: event.summary,
        deadline_at: event.end.date_time,
        weight: 1,
        created_at: event.created
      }
    end
    Task.create(task_list)
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
