json.array!(@users) do |user|
  json.extract! user, :id, :name, :password_digest, :email, :deleted_at
  json.url user_url(user, format: :json)
end
