json.id @task.id
json.title @task.title
json.description @task.description
json.urgency @task.urgency
json.stage @task.stage
json.created_at @task.created_at.strftime("%d %B %Y")
json.persons do
  json.array! @task.to_ids(:persons)
end
json.projects do
  json.array! @task.to_ids(:projects)
end