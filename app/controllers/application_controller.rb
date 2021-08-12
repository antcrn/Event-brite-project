class ApplicationController < ActionController::Base
  before_action :configure_devise_parameters, if: :devise_controller?

  def configure_devise_parameters
    devise_parameter_sanitizer.permit(:sign_up) {|u| u.permit(:first_name, :last_name, :description, :email, :password, :password_confirmation, :current_password)}
    devise_parameter_sanitizer.permit(:account_update) {|u| u.permit(:first_name, :last_name, :description, :email, :password, :password_confirmation, :current_password)}
  end

  def logged_in?
    redirect_to new_user_session_path unless !current_user.nil?
  end

  def only_user?(user)
    redirect_to events_path unless current_user().id == user.id
  end

  def add_participation(user_id, event_id, customer_id = "gratuit")
    Attendance.create(user_id: user_id, event_id: event_id, stripe_customer_id: customer_id)
  end

  def only_administrator(administrator)
    if administrator.nil?
      redirect_to events_path
    else
      only_user?(administrator)
    end
  end
end
