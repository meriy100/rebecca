class GoogleCalendarsController < ApplicationController
  before_action :set_google_calendar
  def update

  end
  def destroy
    @google_calendar.destroy
    redirect_to setting_path
  end

  private

  def set_google_calendar
    @google_calendar = GoogleCalendar.find(params[:id])
  end
end
