require 'rails_helper'

RSpec.describe Project, type: :model do
  it { should validate_presence_of :title }
  it { should have_and_belong_to_many :persons }
  it { should have_and_belong_to_many :notes }
  it { should have_and_belong_to_many :tasks }
end
