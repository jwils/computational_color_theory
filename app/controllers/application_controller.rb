class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :admin_required
  protected
  def admin_required
    authenticate_or_request_with_http_basic do |username, password|
      username == "cis400" && password == "colortheory"
    end
  end
end
