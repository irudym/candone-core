require 'rails_helper'

RSpec.describe Note, type: :model do
  it { should have_and_belong_to_many(:persons) }
  it { should have_and_belong_to_many(:tasks) }

  # Validation tests
  it { should validate_presence_of(:markdown) }
end
