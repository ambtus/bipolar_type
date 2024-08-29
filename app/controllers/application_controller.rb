class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_cookies

  def set_cookies
    Behavior.each do |b|
      cookies[b.mbti] = YAML.load_file('config/my_words.yml')[b.mbti.downcase] if cookies[b.mbti].blank?
    end
  end
end
