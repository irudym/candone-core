class Project < ApplicationRecord
  extend Compare
  include Toids

  has_and_belongs_to_many :persons
  has_and_belongs_to_many :tasks
  has_and_belongs_to_many :notes
  # Validations
  validates_presence_of :title

  def self.create_with_persons_tasks_notes!(permitted_params, params)
    project = Project.create!(permitted_params)
    persons = Person.where(id: params[:persons])
    tasks = Task.where(id: params[:tasks])
    notes = Note.where(id: params[:notes])
    project.persons = persons unless persons.empty?
    project.tasks = tasks unless tasks.empty?
    project.notes = notes unless notes.empty?
    project
  end

  def update_with_persons_tasks_notes(permitted_params, params)
    update(permitted_params)
    if params[:persons]
      project_persons = persons.collect(&:id)
      self.persons = Person.where(id: params[:persons]) unless Project.compare(params[:persons], project_persons)
    end
    if params[:tasks]
      project_tasks = tasks.collect(&:id)
      self.tasks = Task.where(id: params[:tasks]) unless Project.compare(params[:tasks], project_tasks)
    end
    if params[:notes]
      project_notes = notes.collect(&:id)
      self.notes = Note.where(id: params[:notes]) unless Project.compare(params[:notes], project_notes)
    end
    self
  end
end
