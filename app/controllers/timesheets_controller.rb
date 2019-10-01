class TimesheetsController < ApplicationController
  def show
    @clients = harvest_api.clients
    @selected_client = @clients.find {|c| c['id'].to_s == params.dig(:filter, :client_id) } || @clients.first
    @time_entries =
      harvest_api
      .time_entries(client_id: @selected_client['id'])
      .map {|e|
        {
          'date' => e['spent_date'],
          'task' => e['task']['name'],
          'notes' => e['notes'],
          'hours' => e['hours'],
        }
      }
      .group_by {|e| [e['date'], e['task'], e['notes']] }
      .map {|_g, entries|
        entries.first.merge(
          'hours' => entries.sum{|e| e['hours'] }
        )
      }
    @total_hours = @time_entries.sum{|e| e['hours'] }
  end
end
