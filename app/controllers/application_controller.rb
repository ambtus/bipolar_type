# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def home = (@title = 'Introduction')
  def cycle = (@title = 'The Cycle')
  def theory = (@title = 'The Theory')
end
