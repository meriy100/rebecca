require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'

class OathOtherService::GoogleCalendar
  def self.oath_path
    client = Signet::OAuth2::Client.new({
      client_id: ENV.fetch('GOOGLE_API_CLIENT_ID'),
      client_secret: ENV.fetch('GOOGLE_API_CLIENT_SECRET'),
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY,
      redirect_uri: "http://localhost:3000/setting/google_callback"
    })
    client.authorization_uri.to_s
  end

  def self.client_on_code(code)
    Signet::OAuth2::Client.new({
      client_id: ENV.fetch('GOOGLE_API_CLIENT_ID'),
      client_secret: ENV.fetch('GOOGLE_API_CLIENT_SECRET'),
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      redirect_uri: "http://localhost:3000/setting/google_callback",
      code: code
    })
  end

  def self.client(option)
    Signet::OAuth2::Client.new({
      access_token: option[:access_token],
      client_id: ENV.fetch('GOOGLE_API_CLIENT_ID'),
      client_secret: ENV.fetch('GOOGLE_API_CLIENT_SECRET'),
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      token_credential_uri: "https://accounts.google.com/o/oauth2/token",
      expires_in: 3600,
    })
  end

  def self.events(calendar, access_toekn, time_min)
    events = service(access_token).list_events(calendar.id, time_min: time_min.iso8601).items
    # task_list = events.map do |event|
    #   {
    #     title: event.summary,
    #     deadline_at: event.end.date_time,
    #     weight: 1,
    #     created_at: event.created
    #   }
    # end
    # Task.create(task_list)
  end
  def self.service(access_token)
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client(access_token: token)
    service
  end
  def self.calendar_list(token)
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client(access_token: token)
    service.list_calendar_lists
  end
end
