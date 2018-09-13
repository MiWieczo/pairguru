require "rails_helper"

describe Comment, type: :model do
  subject { FactoryBot.create :comment }

  context "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it { is_expected.to validate_presence_of :text }
    it { is_expected.to validate_presence_of :author }
    it { is_expected.to validate_presence_of :movie }
  end

  context "Associations" do
    it { is_expected.to belong_to(:author) }
    it { is_expected.to belong_to(:movie) }
  end
end
