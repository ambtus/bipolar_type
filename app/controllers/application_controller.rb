class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper CookieHelper

  def hide
    %w{colors MBTI general specific}.each do |setting|
      cookies[setting] = params[setting]
    end
  end
end
