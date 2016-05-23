json.array!(@tasks) do |task|
  json.extract! task, :id, :name, :deadline_at, :deleted_at
  json.url task_url(task, format: :json)
end
