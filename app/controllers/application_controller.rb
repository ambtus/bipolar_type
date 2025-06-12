class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_cookies

  def set_cookies
    had_any = false
    cookie_keys = cookies.to_h.keys
    Subtype.each do |subtype|
      k = subtype.tla
      if params.has_key? k
        had_any = true
        if cookies[k].present? && params[k].blank? || (params[k] == subtype.act)
          Rails.logger.debug "deleting #{k}: #{params[k]}"
          cookies.delete(k)
          cookie_keys.delete(k)
        elsif params[k].present? && (params[k] != cookies[k])
          Rails.logger.debug "adding #{k}: #{params[k]}"
          cookies[k] = params[k]
        end
      end
    end
    if had_any
      cookie_keys.each {|k| cookies.delete(k)}
    end
  end

end
