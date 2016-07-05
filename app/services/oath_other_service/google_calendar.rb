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

  def self.client(code)
    Signet::OAuth2::Client.new({
      client_id: ENV.fetch('GOOGLE_API_CLIENT_ID'),
      client_secret: ENV.fetch('GOOGLE_API_CLIENT_SECRET'),
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      redirect_uri: "http://localhost:3000/setting/google_callback",
      code: code
    })
  end

  def self.events
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
  end
  def self.calendar_list(token)
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = Signet::OAuth2::Client.new(access_token: token)
    service.list_calendar_lists
  end
end
