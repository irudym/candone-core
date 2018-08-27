class Task < ApplicationRecord
  extend Compare
  include Toids

  has_and_belongs_to_many :persons
  has_and_belongs_to_many :notes
  has_and_belongs_to_many :projects
  # Validations
  validates_presence_of :title

  def self.create_with_persons!(person_ids, task_params)
    task = Task.create!(task_params)
    persons = Person.where(id: person_ids)
    task.persons = persons unless persons.empty?
    task
  end

  def update_with_persons(person_ids, task_params)
    update(task_params)
    if person_ids.nil?
      return self
    end
    task_persons = self.persons.collect(&:id)
    self.persons = Person.where(id: person_ids) unless Task.compare(person_ids, task_persons)
    self
  end
end
