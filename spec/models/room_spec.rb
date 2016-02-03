require 'rails_helper'

RSpec.describe Room, type: :model do
  describe "Associations" do
    it { is_expected.to belong_to(:day) }
    it { is_expected.to have_many(:workshops) }
  end
  describe "Validations" do
    it { is_expected.to validate_presence_of(:name) }
  end
end
