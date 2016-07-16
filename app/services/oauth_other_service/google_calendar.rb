require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'

class OauthOtherService::GoogleCalendar
  AuthorizationURI = "https://accounts.google.com/o/oauth2/auth".freeze
  def self.import(calendar)
    events(calendar.calendar_id, calendar.access_token, calendar.refresh_token, Time.zone.now).map do |event|
      {
        summary: event.summary,
        date: (event.start.date_time || event.start.date),
        description: event.description,
        sync_token: event.id
      }
    end
  rescue Signet::AuthorizationError
    calendar.disable!
    false
  end

  def self.oauth_path
    Signet::OAuth2::Client.new(
      client_id: ENV.fetch('GOOGLE_API_CLIENT_ID'),
      client_secret: ENV.fetch('GOOGLE_API_CLIENT_SECRET'),
      authorization_uri: AuthorizationURI,
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY,
      redirect_uri: "http://localhost:3000/google_accounts/google_callback"
    ).authorization_uri.to_s
  end

  def self.client_on_code(code)
    Signet::OAuth2::Client.new(
      client_id: ENV.fetch('GOOGLE_API_CLIENT_ID'),
      client_secret: ENV.fetch('GOOGLE_API_CLIENT_SECRET'),
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      redirect_uri: "http://localhost:3000/google_accounts/google_callback",
      code: code
    )
  end

  def self.client(option)
    Signet::OAuth2::Client.new(
      access_token: option[:access_token],
      client_id: ENV.fetch('GOOGLE_API_CLIENT_ID'),
      client_secret: ENV.fetch('GOOGLE_API_CLIENT_SECRET'),
      token_credential_uri: "https://accounts.google.com/o/oauth2/token",
      expires_in: 3600,
      refresh_token: option[:refresh_token]
    )
  end

  def self.events(calendar_id, access_token, refresh_token, time_min)
    service(access_token, refresh_token).list_events(calendar_id, time_min: time_min.iso8601, single_events: true).items
  end

  def self.service(access_token, refresh_token = nil)
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client(access_token: access_token, refresh_token: refresh_token)
    service.authorization.fetch_access_token! if refresh_token.present?
    service
  end

  def self.calendar_list(token)
    service(token).list_calendar_lists
  end
end
