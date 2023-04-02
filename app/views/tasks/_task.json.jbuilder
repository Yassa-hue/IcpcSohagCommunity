json.extract! task, :id, :todo, :deadline, :coach_id, :trainee_id, :created_at, :updated_at
json.url task_url(task, format: :json)
