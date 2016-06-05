json.set! :tasks do
  json.array! @tasks do |task|
    json.user_id task.user_id
    json.sync_token task.sync_token
    json.title task.title
    json.is_done task.is_done
    json.weight task.weight
    json.deadline_at task.deadline_at.strftime('%Y-%m-%d %H:%M:%S')
    json.created_at task.created_at.strftime('%Y-%m-%d %H:%M:%S')
    json.updated_at task.updated_at.strftime('%Y-%m-%d %H:%M:%S')
  end
end
json.set! :user do
  json.set! :id, @current_user.id
  json.set! :name, @current_user.name
  json.set! :email, @current_user.email
end
