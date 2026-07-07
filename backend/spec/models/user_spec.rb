require "rails_helper"

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    expect(build(:user)).to be_valid
  end

  it "requires an email" do
    user = build(:user, email: nil)

    expect(user).not_to be_valid
  end
end
