# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def home = (@title = 'Introduction')

  def cycle = (@title = 'Cycle')

  def signals = (@title = 'Signals')
end
