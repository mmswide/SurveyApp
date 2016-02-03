require 'rails_helper'

RSpec.describe Day, type: :model do
  describe "Associations" do
    it { is_expected.to belong_to(:event) }
    it { is_expected.to have_many(:sub_events) }
    it { is_expected.to have_many(:rooms) }
  end
  describe "Validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:date) }
  end
end
