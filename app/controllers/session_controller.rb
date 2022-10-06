class SessionController < ApplicationController
  def new
    # @user vss user co the dung @user thong method khac con user thi chi dung trong ham do (local var)
  end
  def create
    user =User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      log_in user
      params[:remember_me]=='1' ? remember(user) : forget(user)
      flash.now[:success] = " Login successfully welcome to the Sample App!"
      redirect_back_or user
    else
      flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end

  def destroy
   
    log_out if logged_in?  #thuc su dang nhap thi moi logoinS
      flash[:success] = " Logout successfully"
      redirect_to root_path
    end

 

end
