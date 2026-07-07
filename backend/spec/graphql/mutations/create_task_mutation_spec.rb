require "rails_helper"

RSpec.describe "CreateTaskMutation", type: :request do
  let!(:current_user) { create(:user) }
  let(:workspace) { create(:workspace, owner: current_user) }
  let(:project) { create(:project, workspace: workspace) }

  let(:token) do
    Identity::Infrastructure::Authentication::JwtEncoder.call(current_user)
  end

  let(:headers) do
    {
      "Authorization" => "Bearer #{token}"
    }
  end

  let(:query) do
    <<~GRAPHQL
        mutation {
          createTask(
            input: {
              projectId: "#{project.id}"
              title: "First Task",
              description: ""
            }
          ) {
            task {
              id
              title
              position
            }
            errors
          }
        }
      GRAPHQL
  end

  it "creates a task" do
    expect do
      post "/graphql",
        params: { query: query },
        headers: headers
    end.to change(Task, :count).by(1)

    json = JSON.parse(response.body)

    expect(
      json.dig("data", "createTask", "task", "title")
    ).to eq("First Task")

    expect(
      json.dig("data", "createTask", "errors")
    ).to eq([])
  end
end