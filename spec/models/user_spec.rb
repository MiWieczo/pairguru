require "rails_helper"

describe User, type: :model do
  
  subject { FactoryBot.create :user }
  let(:create_this_week_comment) { FactoryBot.create :comment, :this_week, author: subject }
  let(:create_older_comment) { FactoryBot.create :comment, :older, author: subject }
  
  describe "Associations" do
    
    it { should have_many(:comments) }
    it { should have_many(:comments_this_week) }
        
    it "should distinguish this week's comments from the older ones" do
      this_week_comment = create_this_week_comment
      older_comment = create_older_comment
      expect(subject.comments_this_week.last).to eq(this_week_comment)
      expect(subject.comments.where("created_at < ?", 1.week.ago).last).to eq(older_comment)
    end
  end
  
  describe "#comments_count" do

  end
  
  describe "Phone number" do
    it { is_expected.to allow_value("+48 999 888 777").for(:phone_number) }
    it { is_expected.to allow_value("48 999-888-777").for(:phone_number) }
    it { is_expected.to allow_value("48 999-888-777").for(:phone_number) }
    it { is_expected.not_to allow_value("+48 aaa bbb ccc").for(:phone_number) }
    it { is_expected.not_to allow_value("aaa +48 aaa bbb ccc").for(:phone_number) }
    it { is_expected.not_to allow_value("+48 999 888 777\naseasd").for(:phone_number) }
  end
  
end
