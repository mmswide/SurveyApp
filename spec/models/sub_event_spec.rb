require 'rails_helper'

RSpec.describe SubEvent, type: :model do
  describe "Associations" do
    it { is_expected.to belong_to(:day) }
  end
  describe "Validations" do
    it { is_expected.to validate_presence_of(:hour) }
    it { is_expected.to validate_presence_of(:description) }
  end
end
