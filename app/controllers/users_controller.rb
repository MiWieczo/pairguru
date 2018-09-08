class UsersController < ApplicationController
    def display_top_users
      @top_users = User.top_ten_users
    end
end
