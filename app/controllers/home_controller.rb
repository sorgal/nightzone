class HomeController < ApplicationController
  skip_before_filter :authorize_admin
  def index
  end
end
