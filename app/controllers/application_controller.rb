class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper CookieHelper

  def reload_words
    Rails.logger.debug "accessing file system"
    @words = YAML.load_file('config/words.yml')
  end
  def get_words
    #FIXME want to set it once in production but on every request in development.
    @words || reload_words
  end

  def get_mine
    Rails.logger.debug "accessing file system"
    @words = YAML.load_file('config/my_words.yml')
  end

  def hide
    %w{colors MBTI general specific}.each do |setting|
      if params[setting] == '0'
        cookies[setting] = 'hide'
      else
        cookies.delete(setting)
      end
    end
  end
end
