Rails.application.load_tasks

RSpec.describe 'demo_date' do
  describe ':create' do
    let(:task) { Rake::Task['demo_data:create'] }

    it 'creates PointedEvent' do
      expect { task.invoke }.to change PointedEvent, :count
    end
  end
end
