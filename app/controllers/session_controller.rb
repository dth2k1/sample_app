class SessionController < ApplicationController
  def new
    # @user vss user co the dung @user thong method khac con user thi chi dung trong ham do (local var)
  end
  def create
    user =User.find_by(email: params[:email].downcase)
    puts user
    if user && user.authenticate(params[:password])
      add_id_in_session user
      flash[:success] = " Login successfully welcome to the Sample App!"
      redirect_to user
    else
      flash[:danger] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end

  def destroy
   
      session[:user_id] =nil
      flash[:notice] = " Logout successfully"
      redirect_to root_path
    end

 

end
