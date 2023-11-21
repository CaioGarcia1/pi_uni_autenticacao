class ApplicationController < ActionController::Base
  before_action :set_current_user
  before_action :verify_current_user
  after_action :track_action

  private
  
  def set_current_user
    if session[:user_id]
      Current.user = User.find_by(id: session[:user_id])
      ahoy.authenticate(Current.user)
    end
  end

  def verify_current_user
    if !Current.user.present?
      redirect_to sign_in_path
    end
  end

  protected

  def track_action
    ahoy.track "Ran action", request.path_parameters
  end
end
