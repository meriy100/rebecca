class GoogleAccountsController < ApplicationController
  def google_callback
    client = OauthOtherService::GoogleCalendar.client_on_code(params[:code])
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
    redirect_to setting_path, notice: "#{google_account.google_calendars.count}件のカレンダー情報をとりこみました"
  end
end
