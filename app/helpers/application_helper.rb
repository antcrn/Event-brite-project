module ApplicationHelper
  def logged_in?
    !current_user.nil?
  end

  def only_user?(user)
    current_user().id == user.id
  end

  def calculate_end(event)
    event.start_date + event.duration.minutes
  end
end
