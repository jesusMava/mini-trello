RSpec.describe Tasks::Infrastructure::Subscribers::TaskMovedSubscriber do
  subject(:subscriber) { described_class.new }

  let(:event) do
    Tasks::Application::Events::TaskMoved.new(
      task_id: 1,
      project_id: 2,
      old_position: 1,
      new_position: 3,
      user_id: 99
    )
  end

  before do
    allow(TaskMovedJob).to receive(:perform_async)
  end

  it "enqueues a sidekiq job" do
    subscriber.call(event)

    expect(TaskMovedJob)
      .to have_received(:perform_async)
      .with(hash_including("task_id" => 1))
  end
end
