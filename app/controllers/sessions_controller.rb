class SessionsController < ApplicationController
  skip_before_action :ensure_authenticated!

  def new; end

  def create
    session[:harvest_account_id] = session_params[:harvest_account_id]
    session[:harvest_access_token] = session_params[:harvest_access_token]
    if harvest_api.authenticated?
      redirect_to timesheet_path
    else
      flash[:error] = 'Login failed'
      redirect_to new_sessions_path
    end
  end

  def destroy
    session.clear
  end

  private

  def session_params
    params.require(:session).permit(:harvest_account_id, :harvest_access_token)
  end
end
