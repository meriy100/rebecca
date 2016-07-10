class EventsController < ApplicationController
  before_action :set_event, only: [:update]

  def update
    if @event.update(event_params)
      redirect_to tasks_path
    else
      redirect_to tasks_path
    end
  end

  def import
    google_calendar = GoogleCalendar.find(params[:calendar])
    events_imported = OauthOtherService::GoogleCalendar.import(google_calendar)
    if events_imported
      google_calendar.events.create(events_imported)
      redirect_to tasks_path, notice: "#{events_imported.count}件のイベントを取り込みました"
    else
      redirect_to setting_path, notice: "カレンダーと同期出来ませんでした. もう一度連携してください"
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params[:event].permit(:id, :user_id, :google_calendar_id, :summary, :synk_token, :date, :description, :status)
  end
end
