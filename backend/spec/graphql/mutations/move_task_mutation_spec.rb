require "rails_helper"

RSpec.describe "MoveTaskMutation", type: :request do
  let!(:user) { create(:user) }

  let(:workspace) do
    create(:workspace, owner: user)
  end

  let(:project) do
    create(:project, workspace: workspace)
  end

  let!(:task1) do
    create(
      :task,
      project: project,
      position: 1
    )
  end

  let!(:task2) do
    create(
      :task,
      project: project,
      position: 2
    )
  end

  let(:token) do
    Identity::Infrastructure::Authentication::JwtEncoder.call(user)
  end

  let(:headers) do
    {
      "Authorization" => "Bearer #{token}"
    }
  end

  let(:mutation) do
    <<~GRAPHQL
      mutation {
        moveTask(
          input: {
            projectId: "#{project.id}",
            taskId: "#{task1.id}"
            newPosition: 2
          }
        ) {
          task {
            id
            position
          }
          errors
        }
      }
    GRAPHQL
  end

  let(:wrong_task_id_mutation) do
    mutation {
      moveTask(
        projectId: "#{project.id}",
        taskId: "99999",
        newPosition: 1
      ) {
        errors
      }
    }
  end

  it "moves the task" do
    post "/graphql",
      params: { query: mutation },
      headers: headers

    expect(response).to have_http_status(:ok)

    task1.reload
    task2.reload

    expect(task1.position).to eq(2)
    expect(task2.position).to eq(1)

    json = JSON.parse(response.body)

    expect(
      json.dig(
        "data",
        "moveTask",
        "errors"
      )
    ).to eq([])
  end

  it "returns unauthorized without token" do
    post "/graphql",
    params: { query: mutation }

    json = JSON.parse(response.body)

    expect(
      json["errors"][0]["message"]
    ).to eq("Unauthorized")
  end
end
