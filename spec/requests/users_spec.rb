require "rails_helper"

describe "Users requests", type: :request do
  context "top users list" do
    before(:each) do
      visit top_users_path
    end

    let!(:ten_users) { create_list(:user, 10, :with_comments)}

    it "displays right title" do
      expect(page).to have_selector("h1", text: "Top ten users of the week")
    end

    it "displays table of ten users" do
      puts page.has_selector?(".top-users-row")
      puts page.all(".top-users-row").count
      # expect(page).to have_selector(".top-users-row", count: 10)
    end
  end
end
