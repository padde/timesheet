class RootController < ApplicationController
  def index
    if authenticated?
      redirect_to timesheet_path
    else
      redirect_to new_sessions_path
    end
  end
end
