class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper CookieHelper

  before_action :clean_cookies

  private
    def clean_cookies
      new = {}
      cookies.each do |key, value|
        fixed = URI.decode_www_form_component(key)
        if fixed != key
          Rails.logger.debug "fixing #{key}: #{fixed} #{value}"
          cookies.delete(key)
          new[fixed] = value
        end
      end
      new.each do |key, value|
        cookies[key] = value
      end
    end

end
