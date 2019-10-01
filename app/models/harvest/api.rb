module Harvest
  class API
    include HTTParty
    base_uri 'https://api.harvestapp.com/v2/'

    def initialize(account_id:, access_token:)
      @options = {
        headers: {
          'Authorization' => "Bearer #{access_token}",
          'Harvest-Account-Id' => account_id,
          'User-Agent' => account_id
        }
      }
    end

    def authenticated?
      self.class.get('/users/me', @options).success?
    end

    def clients
      JSON.parse(self.class.get('/clients', @options).body)['clients']
    end

    def time_entries(client_id:)
      JSON.parse(self.class.get('/time_entries', @options.deep_merge(
        query: {
          is_billed: false,
          client_id: client_id
        }
      )).body)['time_entries'].reverse.reject do |entry|
        entry['billable'] == false
      end
    end
  end
end
