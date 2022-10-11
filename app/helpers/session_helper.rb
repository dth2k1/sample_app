module SessionHelper
    # Redirects to stored location (or to the default).
def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
    end
    # Stores the URL trying to be accessed.
def store_location
    session[:forwarding_url] = request.original_url if request.get?
    end
    
    def log_in(user)  #login add session
        session[:user_id] =user.id
    end
    def remember(user)  #luu thong tin user khi thoat trinh duyet khi check remember me
        user.remember
        cookies.permanent.encrypted[:user_id] = user.id
        cookies.permanent[:remember_token] =user.remember_token
    end
    #tim currentuser
    def current_user   #check current user dua tren session va cookie
        if (user_id=session[:user_id])
            @current_user ||= User.find_by(id: user_id) #nill hoac ..
        elsif (user_id =cookies.encrypted[:user_id])
            user=User.find_by(id: user_id)
            if user && user.authenticated?(:remember, cookies[:remember_token])
                log_in user
                @current_user = user
            end

        end            
    end
    
    def logged_in?    #check xem user co khong
        !current_user.nil?
        end
        #logoout delete cookie
        def forget(user)
            user.forget
            cookies.delete(:user_id)
            cookies.delete(:remember_token)
        end
       def log_out   #thuc su logout
forget(current_user)
        session.delete(:user_id)
        @current_user=nil
       end
      

        #check current user
        def current_user?(user)
          user && user==  current_user 
        end


end
