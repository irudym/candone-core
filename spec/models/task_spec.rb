require 'rails_helper'

RSpec.describe Task, type: :model do
  it { should validate_presence_of(:title) }
  it { should have_and_belong_to_many(:persons)}

  context 'Analytic tracking' do 
    let!(:tasks) { create_list(:task,5) }
    let(:task_id) { tasks.first.id }

    before { tasks.first.update(stage: 2) }

    it 'handles task update to complete (stage:2) and tracks stage field' do
      task = tasks.first
      expect(task.completed_at).to eq(Date.current)
    end

    it 'erases complete_at if staged changhed from 2' do
      tasks.first.update(stage: 0)
      task = tasks.first
      expect(task.completed_at).to eq(nil)
    end
  end
end
