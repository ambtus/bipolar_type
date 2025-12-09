# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def home = (@title = 'Introduction')
  def cycle = (@title = 'The Cycle')
  def theory = (@title = 'The Theory')

  %w[attitude behavior mood realm subtype].each do |x|
    define_method(x) do
      @title = x.capitalize.constantize.title
      render x.pluralize
    end
  end
end
