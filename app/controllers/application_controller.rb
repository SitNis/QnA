class ApplicationController < ActionController::Base
  before_action :gon_user, unless: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to root_path, alert: exception.message }
      format.js   { head :forbidden }
    end
  end

  private

  def gon_user
    gon.user_id = current_user.id if current_user
  end
end
