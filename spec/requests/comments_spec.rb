require "rails_helper"

describe "Comments requests", type: :request do
  describe "comments list" do
    comments_sample = rand(5..20)
    let(:chosen_movie) { FactoryBot.create :movie, id: rand(1..20) }
    let!(:comments_list) { create_list(:comment, comments_sample, movie_id: chosen_movie.id) }

    it "displays related comments" do
      visit "/movies/" + chosen_movie.id.to_s
      expect(page).to have_selector(".row.comment", count: comments_sample)
    end
  end

  describe "create comment" do

  end

  describe "delete comment" do

  end
end
