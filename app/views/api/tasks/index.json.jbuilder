json.tasks @tasks do |task|
  json.extract! task, :id, :name, :deadline_at, :deleted_at
end
json.set! :user do
  json.set! :id, @user.id
  json.set! :name, @user.name
  json.set! :email, @user.email
end