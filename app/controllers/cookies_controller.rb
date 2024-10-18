class CookiesController < ApplicationController

  SETTINGS = %w{symbols words both}

  def update
    case params[:commit]
    when 'Letters'
      cookies[:setting] = 'letters'
    when 'Words'
      cookies[:setting] = 'words'
    when 'Both'
      cookies.delete('setting')
    when 'Save', nil
      words = Rails.application.config_for(:words)
      words.keys.each do |k|
        if params.has_key? k
          if params[k].blank? || (params[k] == words[k].first)
            cookies.delete(k)
          else
            cookies[k] = params[k]
          end
        end
      end
      if params[:commit].blank?
        @words = words
        @url = cookies_path(cookies.to_hash)
        render 'cookies' and return
      end
    end

    redirect_back fallback_location: root_path
  end
end
