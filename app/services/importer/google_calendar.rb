require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'

require 'fileutils'

class Importer::GoogleCalendar
  def self.import calendar
    events(calendar.calendar_id, calendar.google_account.access_token, calendar.google_account.refresh_token, Time.zone.now).map do |event|
      {
        summary: event.summary,
        date: (event.start.date_time || event.start.date),
        description: event.description,
        sync_token: event.id
      }
    end
  end
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
      refresh_token: option[:refresh_token]
    })
  end

  def self.events(calendar_id, access_token, refresh_token, time_min)
    events = service(access_token, refresh_token).list_events(calendar_id, time_min: time_min.iso8601, single_events: true).items
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
  def self.service(access_token, refresh_token = nil)
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client(access_token: access_token, refresh_token: refresh_token)
    service.authorization.fetch_access_token! if refresh_token.present?
    service
  end
  def self.calendar_list(token)
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client(access_token: token)
    service.list_calendar_lists
  end
  def self.generate_access_token_request
  end
end
