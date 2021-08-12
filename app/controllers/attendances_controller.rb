class AttendancesController < ApplicationController
  before_action :event_admin, only: %i[ show ]
  before_action only: [:show] do
    only_user?(@administrator)
  end

  def show
    @participants = Attendance.where(event_id: @event.id)
  end

  def create
    Attendance.create(user_id: params[:user_id] ,event_id: params[:event_id])
    redirect_to event_path(params[:event_id])
  end

  private
    
  def event_admin
    @event = Event.find_by(id: params[:id])
    @administrator = @event.administrator
  end
end   