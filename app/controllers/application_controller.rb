class ApplicationController < ActionController::Base
  before_action :set_cookies

  def set_cookies
    had_any = false
    cookie_keys = cookies.to_h.keys
    Subtype.each do |subtype|
      k = subtype.tla
      if params.has_key? k
        had_any = true
        if cookies[k].present? && params[k].blank? || (params[k] == subtype.action)
          Rails.logger.debug {"deleting #{k}: #{params[k]}"}
          cookies.delete(k)
          cookie_keys.delete(k)
        elsif params[k].present? && (params[k] != cookies[k])
          Rails.logger.debug "adding #{k}: #{params[k]}"
          cookies[k] = params[k]
          cookie_keys.delete(k)
        elsif params[k].present? && (params[k] == cookies[k])
          Rails.logger.debug "unchanged #{k}: #{params[k]}"
          cookie_keys.delete(k)
        end
      end
    end
    if had_any
      cookie_keys.each {|k| cookies.delete(k)}
    end
  end

end
