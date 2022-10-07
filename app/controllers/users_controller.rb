class UsersController < ApplicationController
    before_action :logged_in_user, only: [:edit, :update,:destroy ,:index]  #muon update phai dnag nhap con read thi khong can
    before_action :correct_user, only: [:edit, :update]
    before_action :admin_user, only: :destroy
    def new   #method new post 
      @user =User.new
    end
    def show  # method  show router: /user/:id get
      @user =User.find(params[:id])
      redirect_to root_url and return unless @user.activated
    end
    def index # method  show all router: /user get
      # @users = User.paginate(:page => 1, :per_page => 2)
      # @users = User.paginate(:page => params[:page])

# or, use an explicit "per page" limit:
@users =User.where(activated:true).paginate(:page => params[:page], :per_page => 20)

    end
    def edit # method  show all router: /user/:id/edit get
      @user = User.find(params[:id])
    end
    def create #post  router: /user
     @user = User.new(user_params)
  if @user.save   
    #gui email de xac thuc account khi tao tk
    @user.send_activation_email
    flash[:info] = "Please check your email to activate your account."
redirect_to root_url

    # log_in @user
    # flash[:success] = "Welcome to the Sample App!"
    # redirect_to root_path  #render to show  new user
    
  else
    render 'new'
  end
    end
  def update  #patch /user/:id
    @user =User.find(params[:id])
  
   if  @user.update(user_params)
    flash[:success] = "Update successfully"
    redirect_to @user
   else
    render 'edit'
   end
  
  
  end 
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "delete success fully"
    redirect_to users_url
end
  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
    :password_confirmation)
    end  
    def admin_user
      flash[:success] = "You are not permiition"
      redirect_to(root_url) unless current_user.admin?
      end
      
end
