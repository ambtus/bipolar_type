class CookiesController < ApplicationController

  SETTINGS = %w{symbols words focus_colors phase_colors}

  def update
    case params[:commit]
    when 'Off'
      SETTINGS.each {|s| cookies[s] = 'hide'}
    when 'On'
      SETTINGS.each {|s| cookies.delete(s)}
    when 'Toggle'
      SETTINGS.each {|s| cookies.delete(s)}
      SETTINGS.each {|s| cookies[s] = 'hide' if params[s] == '0'}
    when 'Restore'
      params.keys.each {|k| cookies.delete(k)}
    when 'Change'
      words = Rails.application.config_for(:words)
      words.keys.each do |k|
        if params.has_key? k
          if params[k] == words[k]
            cookies.delete(k)
          else
            cookies[k] = params[k]
          end
        end
      end
      Problem.symbols.each do |ps|
        if params.has_key? ps
          cookies[ps] = params[ps]
        end
      end
    end

    redirect_back fallback_location: root_path
  end
end
