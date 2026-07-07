require "rails_helper"

RSpec.describe Identity::Application::UseCases::RegisterUser do
  subject(:use_case) { described_class.new }

  it "creates a user successfully" do
    request = Identity::Application::Dto::RegisterRequest.new(
      first_name: "Jesus",
      last_name: "Mava",
      email: "jesus@example.com",
      password: "Password123"
    )

    result = use_case.call(request)

    expect(result.success?).to be(true)
    expect(result.user.email).to eq("jesus@example.com")
  end
end
