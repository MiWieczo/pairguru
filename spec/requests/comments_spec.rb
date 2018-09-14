require "rails_helper"

describe "Comments requests", type: :request do
  let(:chosen_movie) { FactoryBot.create :movie, id: rand(1..20) }
  describe "comments list" do
    comments_sample = rand(5..20)

    let!(:comments_list) { create_list(:comment, comments_sample, movie_id: chosen_movie.id) }

    it "displays related comments" do
      visit "/movies/" + chosen_movie.id.to_s
      expect(page).to have_selector(".row.comment", count: comments_sample)
    end
  end

  describe "POST #create" do

    before(:each) do
      user = FactoryBot.create :user
      user.confirm
      sign_in(user)
    end

    let(:post_valid_comment) { post "/movies/" + chosen_movie.id.to_s + "/comments",
                      params: { comment: {text: "new comment"},
                      movie_id: chosen_movie.id }}
    let(:post_invalid_comment) { post "/movies/" + chosen_movie.id.to_s + "/comments",
                      params: { comment: {text: nil},
                      movie_id: chosen_movie.id }}

    context "with valid attributes" do

      it "creates new comment" do
        expect { post_valid_comment }.to change(Comment, :count).by(1)
      end

      it "redirects to movie page" do
        post_valid_comment
        expect(response).to redirect_to movie_path(chosen_movie)
      end
    end

    context "with invalid attributes" do

      it "forbids to add new comment" do
        expect { post_invalid_comment }.to change(Comment, :count).by(0)
      end

      it "redirects to movie page" do
        post_invalid_comment
        expect(response).to redirect_to movie_path(chosen_movie)
      end

    end

    context "there is an existing comment from the user under the movie" do

      it "forbids to add comment" do

      end

      it "redirects to movie page" do

      end

    end

  end

  describe "DELETE #destroy" do

    it "deletes the comment" do

    end

    it "forbids to delete the comment" do

    end

  end
end
