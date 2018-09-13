class UsersController < ApplicationController
    def display_top_users
      @top_users = User.all.sort_by(&:number_of_comments_this_week).reverse.take(10)
    end
end
