class NoteSerializer
  include FastJsonapi::ObjectSerializer
  attributes :markdown, :created_at
  has_many :persons
  has_many :tasks
end
