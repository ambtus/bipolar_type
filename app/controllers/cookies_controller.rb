class CookiesController < ApplicationController

  SETTINGS = %w{symbols words both things}

  def update
    case params[:commit]
    when 'TL;DR'
      if cookies[:details]
        cookies.delete(:details)
      else
        cookies[:details] = 'show'
      end
    when 'Symbols'
      cookies[:setting] = 'symbols'
    when 'Words'
      cookies[:setting] = 'words'
    when 'Things'
      cookies[:setting] = 'things'
    when 'Both'
      cookies.delete('setting')
    when 'Save', nil
      words = Rails.application.config_for(:words)
      words.keys.each do |k|
        if params.has_key? k
          if cookies[k].present? && params[k].blank? || (params[k] == words[k])
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
        @words = words
        @alt_words = Rails.application.config_for(:alt_words)
        @url = cookies_path(cookies.to_hash)
        render 'cookies' and return
      end
    end

    redirect_back fallback_location: root_path
  end
end
