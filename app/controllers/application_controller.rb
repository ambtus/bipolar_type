# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_breadcrumbs, except: %i[home basic]
  before_action :set_title, except: %i[home basic]

  def home = (@title = 'Introduction')

  def basic = (@title = 'Basic personality types')

  def midday = (@morning = Realm.find(@breadcrumbs.second))

  def afternoon = (@realms = @breadcrumbs.chip.chars.collect { |x| Realm.find x })

  def evening = (@realms = @breadcrumbs.chip.chars.collect { |x| Realm.find x })

  private

  def set_breadcrumbs = (@breadcrumbs = params[:format])
  def set_title = (@title = action_name.capitalize)
end
