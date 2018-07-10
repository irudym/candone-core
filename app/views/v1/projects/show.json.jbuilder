json.id @project.id
json.created_at @project.created_at
json.title @project.title
json.description @project.description
json.stage @project.stage
json.persons do
  json.array! @project.to_ids(:persons)
end
json.tasks do
  json.array! @project.tasks
end
json.notes do
  json.array! @project.notes do |note|
    json.id note.id
    json.title note.title
  end
end