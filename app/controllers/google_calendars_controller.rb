class GoogleCalendarsController < ApplicationController
  before_action :set_google_calendar
  def update
    @google_calendar.update(google_calendar_params)
    redirect_to setting_path
  end
  def destroy
    @google_calendar.destroy
    redirect_to setting_path
  end

  private

  def set_google_calendar
    @google_calendar = GoogleCalendar.find(params[:id])
  end

  def google_calendar_params
    params[:google_calendar].permit(
      :status
    )
  end
end
