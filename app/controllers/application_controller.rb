# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def home = (@title = 'Introduction')

  def attitudes = (@title = '4 Attitudes')

  def realms = (@title = '4 Realms')

  def behaviors = (@title = '16 Behaviors')
end
