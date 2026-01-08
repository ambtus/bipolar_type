# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def home = (@title = 'Introduction')

  def basic = (@title = 'Basic Type')

  def theory = (@title = 'Theory')

  def behaviors = (@title = 'The 16 Behaviors')

  Action.each do |action|
    define_method action.render do
      @action = action
      basic = params[:format].first
      @realms = params[:format].chip.chars.collect { |x| Realm.find x }
      @breadcrumbs = [basic, *@realms]
      @title = @breadcrumbs.join
      @distressed = (basic == 'i' ? 'stressed' : 'bored')
      @eustressed = (basic == 'i' ? 'bored' : 'stressed')
      @stressed = (@action.index < 2 ? @distressed : @eustressed)
      render 'action'
    end
  end
end
