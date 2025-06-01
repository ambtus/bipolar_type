class CookiesController < ApplicationController

  SETTINGS = %w{ words symbols both }

  def update
    case params[:commit]
    when 'Less'
      cookies.delete(:details)
    when 'More'
      cookies[:details] = 'show'
    when 'Symbols'
      cookies[:setting] = 'symbols'
    when 'Words'
      cookies.delete('setting')
    when 'Both'
      cookies[:setting] = 'both'
    when 'Save', nil
      Words.keys.each do |k|
        if params.has_key? k
          if cookies[k].present? && params[k].blank? || (params[k] == Words[k])
            Rails.logger.debug "deleting #{k}: #{params[k]}"
            cookies.delete(k)
          elsif params[k].present? && (params[k] != cookies[k])
            Rails.logger.debug "adding #{k}: #{params[k]}"
            cookies[k] = params[k]
          end
        end
      end
      Rails.logger.debug 'cookies: ' + cookies.map { |cookie| cookie.join(': ') }.join("\n\t")
      if params[:commit].blank?
        @url = cookies_path(cookies.to_hash)
        render 'cookies' and return
      end
    end

    redirect_back fallback_location: root_path
  end
end
