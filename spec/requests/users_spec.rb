require "rails_helper"

describe "Users requests", type: :request do
  context "top users list" do
    users_sample = rand(5..20)
    let!(:users_list) { create_list(:user, users_sample, :with_comments)}

    it "displays right title" do
      visit top_users_path
      expect(page).to have_selector("h1", text: "Top ten users of the week")
    end

    it "displays table of ten users" do
      get '/top_users'
      expect(response.code).to eq("200")
      expect(response).to render_template(:display_top_users)
      if users_sample < 10
        expect(response.body).to have_selector(".top-users-row", count: users_sample)
      else
        expect(response.body).to have_selector(".top-users-row", count: 10)
      end
    end
  end
end
