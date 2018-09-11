json.id @project.id
json.created_at @project.created_at.strftime("%d %B %Y")
json.title @project.title
json.description @project.description
json.stage @project.stage
json.persons do
  json.array! @project.to_ids(:persons)
end
json.tasks do
  json.array! @project.tasks do |task|
    json.id task.id
    json.title task.title
    json.description task.description
    json.created_at task.created_at.strftime("%d %B %Y")
    json.stage task.stage
    json.urgency task.urgency
    json.persons do
      json.array! task.to_ids(:persons)
    end
  end
end
json.notes do
  json.array! @project.notes do |note|
    json.id note.id
    json.title note.title
    json.participants do
      json.array! note.to_ids(:persons)
    end
    json.actions note.tasks do |task|
      json.id task.id
    end
  end
end