json.array! @persons do |person|
  json.id person.id
  json.first_name person.first_name
  json.last_name person.last_name
  json.email person.email
  json.description person.description
  json.person_type_id person.person_type_id
end