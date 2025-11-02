# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def home = (@title = 'Introduction')
  def cycle = (@title = 'The Cycle')

  def theory
    @title = 'The Theory'
    @subtype = Subtype.send(params[:format] || 'eS')
    @realm = @subtype.realm
  end

  %w[attitude behavior mood realm subtype].each do |x|
    define_method(x) { @title = x.capitalize.constantize.title; render x.pluralize }
  end
end
