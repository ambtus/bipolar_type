# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def home = (@title = 'Introduction')

  def basic = (@title = 'Basic Type')

  def theory = (@title = 'Theory')
end
