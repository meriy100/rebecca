class EventsController < ApplicationController
  before_action :set_event
  def update
  end
  private
  def set_event
    @event = Event.find(params[:id])
  end
  def event_params
    params[:event].premit(
    )
  end
end
