class StacticPagesController < ApplicationController
  
  def home
    if logged_in?
    @micropost = current_user.microposts.build 
    @feed_items =current_user.feed.paginate(page: params[:page], :per_page =>2)
    end
  end

  def help
  end
end
