require 'redcarpet'
require 'redcarpet/render_strip'

class Note < ApplicationRecord
  extend Compare
  include Toids

  has_and_belongs_to_many :persons
  has_and_belongs_to_many :tasks
  has_and_belongs_to_many :projects
  # Validations
  validates_presence_of :markdown

  def title
    # get the first line of the note
    Redcarpet::Markdown.new(Redcarpet::Render::StripDown).render(self.markdown.lines.first)
  end

  def contains_task?(id)
    self.tasks.find(id)
  end

  def update_with_tasks_persons(add_tasks, person_ids, note_params)
    update note_params
    unless add_tasks.nil?
      # create a list of new tasks
      self.tasks = add_tasks.inject([]) do |acc, task|
        begin
          acc << contains_task?(task[:id])
        rescue => details
          new_task = Task.create_with_persons!(task[:person_ids], title: task[:title], description: "Action from a note '#{title}'", urgency: 0)
          acc << new_task

          # add new task to the related projects
          projects.each { |project| project.tasks << new_task }
        end
        acc
      end
    end
    unless person_ids.nil?
      note_persons = persons.collect(&:id)
      self.persons = Person.where(id: person_ids) unless Note.compare(person_ids, note_persons)
    end
    self
  end
end
