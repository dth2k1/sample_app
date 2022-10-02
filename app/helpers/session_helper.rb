module SessionHelper
    def add_id_in_session(user)
        session[:user_id] =user.id
    end
    def current_user
        if session[:user_id]
            @current_user ||= User.find_by(id: session[:user_id]) #nill hoac ..
            end            
    end
    def logged_in?
        !current_user.nil?
        end
        
end
