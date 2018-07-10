require 'rails_helper'

RSpec.describe Person, type: :model do
  # Association test
  # ensure Person model belongs to PersonType model
  # it { should belong_to(:person_type) }

  # Validation tests
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should have_and_belong_to_many(:tasks) }
end
