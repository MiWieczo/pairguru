require "rails_helper"

describe User, type: :model do

  subject { FactoryBot.create :user }
  let(:create_this_week_comment) { FactoryBot.create :comment, :this_week, author: subject }
  let(:create_older_comment) { FactoryBot.create :comment, :older, author: subject }

  describe "Associations" do

    it { should have_many(:comments) }
    it { should have_many(:comments_this_week) }

    it "should distinguish this week's comments from older ones" do
      this_week_comment = create_this_week_comment
      older_comment = create_older_comment
      expect(subject.comments_this_week.last).to eq(this_week_comment)
      expect(subject.comments.where("created_at < ?", 1.week.ago).last).to eq(older_comment)
    end
  end

  describe "#number_of_comments_this_week" do
    it "returns the number of comments the user has created this week" do
      sample = rand(5..20)
      list = create_list(:comment, sample, :this_week, author: subject)
      # This is strange because sometimes
      # the comments in the list above
      # have created_at parameter equal to
      # an earlier moment in time than 1.week.ago which fails the spec.

      # You can look in factories/comment.rb, trait :this_week
      # to check whether I did something wrong or I found a bug in Faker.

      # The line below is for debugging purposes,
      # if you run the spec couple of times, you will see what I mean.
      list.each { |comment| puts "#{comment.created_at} > #{1.week.ago} ? #{comment.created_at > 1.week.ago}" }
      expect(subject.number_of_comments_this_week).to eq(sample)
    end
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
