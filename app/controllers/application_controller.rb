class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :authorize_admin

  protect_from_forgery with: :exception

  def authorize_admin
    if !current_admin_user
      redirect_to "/admin/login"
    end
  end
end
