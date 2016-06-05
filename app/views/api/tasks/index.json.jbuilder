json.tasks @tasks do |task|
  json.extract! task, :id, :name, :deadline_at, :deleted_at
end
json.set! :user do
  json.set! :id, @current_user.id
  json.set! :name, @current_user.name
  json.set! :email, @current_user.email
end
