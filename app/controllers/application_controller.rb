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

  def current_ability
    if current_admin_user
      @current_ability ||= AdminAbility.new(current_admin_user)
    else
      @current_ability ||= Ability.new(current_user)
    end
  end

end
