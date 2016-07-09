class EventsController < ApplicationController
  before_action :set_event, only: [:update]

  def update
  end

  def import
    google_calendar = GoogleCalendar.find(params[:calendar])
    events_imported = Importer::GoogleCalendar.import(google_calendar)
    google_calendar.events.create(events_imported)
    redirect_to tasks_path, notice: "#{events_imported.count}件のイベントを取り込みました"
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params[:event].premit
  end
end
