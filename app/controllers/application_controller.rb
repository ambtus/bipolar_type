# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def home = (@title = 'Introduction')

  def basic = (@title = 'Basic Type')

  def theory = (@title = 'Theory')

  def definitions = (@title = 'Definitions')

  Action.each do |action|
    define_method action.render do
      @action = action
      @basic = Basic.find params[:format].first
      @realms = params[:format].chip.chars.collect { |x| Realm.find x }
      @breadcrumbs = [@basic, *@realms]
      @title = @breadcrumbs.join
      render 'action'
    end
  end
end
