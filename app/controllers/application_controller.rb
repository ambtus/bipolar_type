class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_if_blank
  helper CookieHelper

  PAGES = %w{bipolar unbalanced realms}
  SETTINGS = %w{phase_colors phase_times function_colors MBTI changed_verbs}

  def set_if_blank
    set_verbs if @verbs.blank?
  end
  def set_verbs
    Rails.logger.debug "getting verbs"
    @verbs = Function.cookies.map{|k| [k, Function.send(k)]}.to_h
  end
  def get_my_verbs
    Rails.logger.debug "getting my verbs"
    @verbs = YAML.load_file('config/my_verbs.yml')
    Function.cookies.each {|key| cookies[key] = @verbs[key]}
    cookies['mine'] = true
  end

  def hide_all
    SETTINGS.each {|s| cookies[s] = 'hide'}
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
