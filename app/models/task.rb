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
    puts "TASK: update_with_persons"
    update(task_params)
    if person_ids.nil?
      return self
    end
    task_persons = self.persons.collect(&:id)
    self.persons = Person.where(id: person_ids) unless Task.compare(person_ids, task_persons)
    self
  end

  def short_description
    description.truncate 200
  end

  def update(params)
    new_params = params
    if params[:stage] == '2'
      new_params[:completed_at] = Date.current
    else
      new_params[:completed_at] = nil
    end
    super new_params
  end 

  def self.analytic(date)
    report = [] 
    monday = date.prev_occurring(:monday)
    
    report = (monday...monday+7).inject([]) do |acc, a|

      acc << {date: a, name: a.strftime("%A"), value: Task.where(completed_at: a.to_datetime).count}
    end
    report 
  end
  
end
