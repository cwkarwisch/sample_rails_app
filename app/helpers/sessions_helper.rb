module SessionsHelper

  # Stores the user_id in the session
  def set_user_id_in_session(user_id)
    session[:user_id] = user_id
  end

  # Logs in the given user
  def log_in(user)
    reset_session
    set_user_id_in_session(user.id)
    # Guard against session replay attacks
    session[:session_token] = user.session_token
  end

  # Logs out the user
  def log_out
    forget current_user
    reset_session
    @current_user = nil
  end

  # Returns the current logged-in user (if any)
  def current_user
    user_id = session[:user_id]
    if user_id
      user = User.find_by(id: user_id)
      @current_user ||= user if session[:session_token] == user.session_token
    else
      user_id = cookies.encrypted[:user_id]
      remember_token = cookies[:remember_token]
      if user_id && remember_token
        user = User.find_by(id: user_id)
        if user.authenticated?(remember_token)
          set_user_id_in_session(user_id)
          @current_user = user
        end
      end
    end
  end

  # Returns true if the user is logged in, false otherwise
  def logged_in?
    !!current_user
  end

  # Remembers a user in a permanent session
  def remember(user)
    user.remember
    cookies.permanent.encrypted[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

    # Forget user's permanent session
    def forget(user)
      user.forget
      cookies.delete(:user_id)
      cookies.delete(:remember_token)
    end
end
