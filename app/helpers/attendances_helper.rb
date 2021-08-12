module AttendancesHelper
  def participant_user(participant)
    @user = User.find_by(id: participant.user_id)
    return "#{@user.first_name} #{@user.last_name}"
  end
end
