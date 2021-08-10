module ApplicationHelper
  def logged_in?
    !current_user.nil?
  end

  def only_user?(user)
    current_user().id == user.id
  end
end
