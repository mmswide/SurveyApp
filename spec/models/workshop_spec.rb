require 'rails_helper'

RSpec.describe Workshop, type: :model do
  describe "Associations" do
    it { is_expected.to belong_to(:room) }
  end
  describe "Validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:time) }
    it { is_expected.to validate_presence_of(:location) }
  end
end
