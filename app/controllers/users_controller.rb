class UsersController < ApplicationController
    def display_top_users
      @top_users = User.all.sort_by(&:comments_count).reverse.take(10)
    end
end
