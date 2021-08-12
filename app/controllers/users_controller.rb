class UsersController < ApplicationController
  before_action :logged_in?
  before_action :authenticate_user!, only: %i[ show ]
  
  def show
    @user = User.find(params[:id])
    only_user?(@user)
    @event = Event.where(administrator_id: params[:id])
  end
end 