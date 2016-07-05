require 'open-uri'
require 'json'

class Importer::Todoist
  API_URL = "https://todoist.com/API/v7/sync".freeze

  class << self
    def import(token)
      request_url = create_url(token: token, sync_token: '*', resource_types: '["all"]')
      todoist_tasks = api_request(request_url)
      todoist_tasks["items"].map do |todoist_task|
        {
          title: todoist_task["content"],
          deadline_at: (todoist_task["due_date_utc"].presence || Time.zone.now.since(1.month)),
          created_at: todoist_task["date_added"],
          weight: 1
        }
      end
    end

    private

    def api_request(request_url)
      res = open(request_url)
      code = res.status.first

      code == "200" && JSON.parse(res.read)
    end

    def create_url(params)
      API_URL + '?' + URI.encode_www_form(params)
    end
  end
end
