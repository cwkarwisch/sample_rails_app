class ApplicationController < ActionController::Base
  def hello
    render html: "hi there."
  end
end
