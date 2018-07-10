json.array! @tasks do |task|
  json.id task.id
  json.created_at task.created_at
  json.title task.title
  json.description task.description
  json.urgency task.urgency
  json.stage task.stage
  json.persons do
    json.array! task.to_ids(:persons)
  end

end