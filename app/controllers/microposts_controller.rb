class MicropostsController < ApplicationController
   before_action   :logged_in_user, only: [:create ,:destroy]
   before_action :correct_user, only: :destroy   #truoc khi lam gi 
   def create
@micropost =  current_user.microposts.build(micropost_params)
@micropost.image.attach(params[:micropost][:image])   #ham de lay param file

if @micropost.save
   flash[:success] ="Create success fully micropost"
   redirect_to root_url
else
   @feed_items =current_user.feed.paginate(page: params[:page], :per_page =>2)
   render 'stactic_pages/home'
end

   end

   def destroy
       @micropost.destroy
flash[:success] ="Delete success"
redirect_to request.referrer || root_url   # request referrer tro lai trang trc do
   end


  
   private
   def micropost_params
      params.require(:micropost).permit(:content, :image)
   end

   def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
      end
      
 
end
