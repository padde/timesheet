Rails.application.routes.draw do
  get '/', to: 'root#index'
  resource :sessions, only: %i[new create destroy]
  resource :timesheet, only: %i[show]
end
