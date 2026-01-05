# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_breadcrumbs, except: %i[home basic]
  before_action :set_title, except: %i[home basic]

  def home = (@title = 'Introduction')

  def basic = (@title = 'Basic personality types')

  private

  def set_breadcrumbs
    return unless params[:format].is_a? String

    @realms = params[:format].chip.chars.collect { |x| Realm.find x }
    @breadcrumbs = [params[:format].first, *@realms]
  end
  def set_title = (@title = action_name.capitalize)
end
