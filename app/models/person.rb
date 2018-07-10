class Person < ApplicationRecord
  # belongs_to :person_type
  has_and_belongs_to_many :tasks
  has_and_belongs_to_many :notes
  has_and_belongs_to_many :projects

  # Validations
  validates_presence_of :first_name, :last_name, :email
end
