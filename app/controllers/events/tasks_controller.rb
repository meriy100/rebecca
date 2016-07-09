class Event::TasksController < ApplicationController
  include TasksAction
  before_action :set_event, only: [:index]
  before_action :set_new_task, only: [:index]
  before_action :set_search, only: [:index]

  def index
    @tasks = @event.tasks.on_user.doings.sort_by(&:least_time_per)
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_new_task
    @task = @event.tasks.new
  end
end
