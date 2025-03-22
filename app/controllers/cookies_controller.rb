class CookiesController < ApplicationController

  SETTINGS = %w{symbols words both}

  def update
    case params[:commit]
    when 'Symbols'
      cookies[:setting] = 'symbols'
    when 'Words'
      cookies[:setting] = 'words'
    when 'Both'
      cookies.delete('setting')
    else
      words = Rails.application.config_for(:words)
      words.keys.each do |k|
        if params.has_key? k
          if params[k].blank? || (params[k] == words[k])
            cookies.delete(k)
          else
            cookies[k] = params[k]
          end
        end
      end
    end

    redirect_back fallback_location: root_path
  end
end
