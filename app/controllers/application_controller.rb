class ApplicationController < ActionController::Base
  helper_method :authenticated?
  before_action :ensure_authenticated!

  private

  def ensure_authenticated!
    redirect_to new_sessions_path unless authenticated?
  end

  def authenticated?
    session[:harvest_account_id].present?
  end

  def harvest_api
    Harvest::API.new(
      account_id: session[:harvest_account_id],
      access_token: session[:harvest_access_token]
    )
  end
end
