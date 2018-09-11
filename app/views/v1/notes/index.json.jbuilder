json.array! @notes do |note|
  json.id note.id
  # json.markdown /(.*)/.match(note.markdown)[0]
  json.markdown note.markdown
  json.title note.title
  json.created_at note.created_at.strftime("%d %B %Y")
  json.participants do
    json.array! note.to_ids(:persons)
  end
  json.actions note.tasks do |task|
    json.id task.id
    json.title task.title
    json.created_at task.created_at.strftime("%d %B %Y")
    json.urgency task.urgency
    json.owners do
      json.array! task.to_ids(:persons)
    end
  end
end