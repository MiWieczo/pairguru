require 'rails_helper'

describe Comment, type: :model do

  subject { FactoryBot.create :comment } 
  
  context "Validations" do

    it "is valid with valid attirbutes" do
      expect(subject).to be_valid
    end

    it "is invalid without text" do
      subject.text = nil
      expect(subject).not_to be_valid
    end

    it "is invalid without an author" do
      subject.author = nil
      expect(subject).not_to be_valid
    end

    it "is invalid without a movie" do
      subject.movie = nil
      expect(subject).not_to be_valid
    end

    it "is invalid without creation date" do
      subject.created_at = nil
      expect(subject).not_to be_valid
    end
  end

  context "Associations" do

  end

end
