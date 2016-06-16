json.set! :user_id, @task.user_id
json.set! :sync_token, @task.sync_token
json.set! :title, @task.title
json.set! :is_done, @task.is_done
json.set! :weight, @task.weight
json.set! :deadline_at, @task.deadline_at.try(:strftime, '%Y-%m-%d %H:%M:%S')
json.set! :created_at, @task.created_at.try(:strftime, '%Y-%m-%d %H:%M:%S')
json.set! :updated_at, @task.updated_at.try(:strftime, '%Y-%m-%d %H:%M:%S')
json.set! :errors, @task.errors.full_messages
