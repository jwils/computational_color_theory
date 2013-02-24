class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
  def admin_required
    authenticate_or_request_with_http_basic do |user_name, password|
      user_name == 'admin' && password == 'cis400'
    end if Rails.env.production? || params[:admin_http]
  end
end
