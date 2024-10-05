class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_if_blank
  helper CookieHelper

  PAGES = %w{bipolar unbalanced realms}
  SETTINGS = %w{state_colors phase_times function_colors MBTI changed_words}

  def set_if_blank
    set_words if @words.blank?
  end
  def set_words
    Rails.logger.debug "getting words"
    @words = Function.cookies.map{|k| [k, Function.send(k)]}.to_h
    @words['E'] = State.e.name
    @words['I'] = State.i.name
  end
  def get_my_words
    Rails.logger.debug "getting my words"
    @words = YAML.load_file('config/my_words.yml')
    Function.cookies.each {|key| cookies[key] = @words[key]}
    cookies['mine'] = true
  end


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
