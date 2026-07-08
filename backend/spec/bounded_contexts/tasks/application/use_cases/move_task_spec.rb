require "rails_helper"

RSpec.describe Tasks::Application::UseCases::MoveTask do
  subject(:use_case) do
    described_class.new(
      task_repository: repository,
      position_manager: position_manager,
      event_bus: event_bus
    )
  end

  let(:repository) { instance_double(
    Tasks::Infrastructure::Repositories::TaskRepository
  ) }

  let(:position_manager) do
    instance_double(
      Tasks::Domain::Services::PositionManager
    )
  end

  let(:request) do
    Tasks::Application::Dto::MoveTaskRequest.new(
      project_id: 1,
      task_id: 10,
      owner_id: 20,
      new_position: 3
    )
  end

  let(:event_bus) do
    instance_double(
      Shared::Events::EventBus
    )
  end

  it "moves the task successfully" do
    task = build_stubbed(:task)

    allow(repository)
      .to receive(:find_accessible_by_owner)
      .and_return(task)

    allow(position_manager).to receive(:move)
    allow(event_bus).to receive(:publish)

    result = use_case.call(request)

    expect(position_manager)
      .to have_received(:move)
      .with(
        task: task,
        new_position: 3
      )

    expect(event_bus)
      .to have_received(:publish)
      .with(
        an_instance_of(
          Tasks::Application::Events::TaskMoved
        )
      )

      expect(result).to be_success
      expect(result.task).to eq(task)
      expect(result.errors).to be_empty
  end

  it "returns not found" do
    allow(repository)
      .to receive(:find_accessible_by_owner)
      .and_return(nil)

    result = use_case.call(request)

    expect(result).not_to be_success
    expect(result.task).to be_nil
    expect(result.errors).to include("Task not found")
  end

  it "returns conflict" do
    task = build_stubbed(:task)
    allow(repository)
      .to receive(:find_accessible_by_owner)
      .and_return(task)

    allow(position_manager)
      .to receive(:move)
      .and_raise(
        ActiveRecord::StaleObjectError.new(task, "update")
      )

    result = use_case.call(request)

    expect(result).not_to be_success
    expect(result.errors.first).to match(/modified/i)
  end

  it "loads task by owner" do
    task = build_stubbed(:task)

    allow(repository)
      .to receive(:find_accessible_by_owner)
      .and_return(task)

    allow(position_manager).to receive(:move)
    allow(event_bus).to receive(:publish)

    use_case.call(request)

    expect(repository)
      .to have_received(:find_accessible_by_owner)
      .with(
        project_id: 1,
        task_id: 10,
        owner_id: 20
      )
  end
end
