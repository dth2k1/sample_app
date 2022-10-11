class ApplicationController < ActionController::Base
  include SessionHelper
  private
  def logged_in_user
    unless logged_in?   #giong middleware
        store_location
        flash[:danger] ="Please login to action"
        redirect_to login_url
    end
    end
end
