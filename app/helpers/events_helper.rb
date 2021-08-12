module EventsHelper
  def is_participant?
    !Attendance.find_by(user_id: current_user.id, event_id: params[:id]).nil?
  end

  def is_free?(event)
    !(event.price > 0)
  end
end
