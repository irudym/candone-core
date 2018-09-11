json.id @note.id
json.title @note.title
json.markdown @note.markdown
json.created_at @note.created_at.strftime("%d %B %Y")
json.participants do
  json.array! @note.to_ids(:persons)
end
json.actions @note.tasks do |task|
  json.id task.id
  json.title task.title
  json.owners do
    json.array! task.to_ids(:persons)
  end
end
json.projects do
  json.array! @note.to_ids(:projects)
end