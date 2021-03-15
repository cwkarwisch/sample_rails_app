module SessionsHelper

  # Logs in the given user
  def log_in(user)
    reset_session
    session[:user_id] = user.id
  end

  # Logs out the user
  def log_out
    reset_session
    @current_user = nil
  end

  # Returns the current logged-in user (if any)
  def current_user
    user_id = session[:user_id]
    if user_id
      @current_user ||= User.find_by(id: user_id)
    end
  end

  # Returns true if the user is logged in, false otherwise
  def logged_in?
    !!current_user
  end
end
