json.extract! user, :id, :name, :email, :password_digest, :codeforces_handle, :role, :level, :title, :created_at, :updated_at
json.url user_url(user, format: :json)
