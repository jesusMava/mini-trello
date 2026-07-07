# frozen_string_literal: true

require "rails_helper"

RSpec.describe Tasks::Domain::Services::PositionManager do
  subject(:service) do
    described_class.new(task_repository: repository)
  end

  let(:repository) do
    Tasks::Infrastructure::Repositories::TaskRepository.new
  end
  let(:owner) { create(:user) }
  let(:workspace) do
    create(:workspace, owner: owner)
  end
  let(:project) do
    create(:project, workspace: workspace)
  end
  let!(:task1) { create(:task, project: project, position: 1) }
  let!(:task2) { create(:task, project: project, position: 2) }
  let!(:task3) { create(:task, project: project, position: 3) }
  let!(:task4) { create(:task, project: project, position: 4) }

  it "moves a task upward" do
    service.move(task: task4, new_position: 2)

    expect(task1.reload.position).to eq(1)
    expect(task4.reload.position).to eq(2)
    expect(task2.reload.position).to eq(3)
    expect(task3.reload.position).to eq(4)
  end

  it "moves a task downward" do
    service.move(task: task2, new_position: 4)

    expect(task1.reload.position).to eq(1)
    expect(task3.reload.position).to eq(2)
    expect(task4.reload.position).to eq(3)
    expect(task2.reload.position).to eq(4)
  end

  it "does nothing when moving to the same position" do
    expect do
      service.move(task: task2, new_position: 2)
    end.not_to change {
      task2.reload.position
    }
  end

  it "moves to the last position when position is greater than max" do
    service.move(task: task2, new_position: 100)

    expect(task2.reload.position).to eq(4)
  end

  it "moves to first position" do
    service.move(task: task4, new_position: 1)

    expect(task4.reload.position).to eq(1)
    expect(task1.reload.position).to eq(2)
    expect(task2.reload.position).to eq(3)
    expect(task3.reload.position).to eq(4)
  end

  it "moves to last position" do
    service.move(task: task1, new_position: 4)

    expect(task2.reload.position).to eq(1)
    expect(task3.reload.position).to eq(2)
    expect(task4.reload.position).to eq(3)
    expect(task1.reload.position).to eq(4)
  end

  it "raises stale object error" do
    first = Task.find(task1.id)
    second = Task.find(task1.id)

    first.update!(title: "Updated")

    expect {
      second.update!(title: "Another")
    }.to raise_error(
      ActiveRecord::StaleObjectError
    )
  end
end
