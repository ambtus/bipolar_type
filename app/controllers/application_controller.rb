class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper CookieHelper

  #FIXME want to set it once in production but on every request in development.
  def reload_words
    Rails.logger.debug "accessing file system"
    @words = YAML.load_file('config/words.yml')
  end
  def get_words
    Rails.logger.debug "getting words"
    @words || reload_words
  end

  SETTINGS = %w{colors MBTI trigger reaction my_words}
  def hide
    SETTINGS.each do |setting|
      if params[setting] == '0'
        cookies[setting] = 'hide'
      else
        cookies.delete(setting)
      end
    end
  end
end
