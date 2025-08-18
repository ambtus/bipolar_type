# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def home = (@title = 'Introduction')

  def attitudes = (@title = '4 Attitudes')

  def realms = (@title = '4 Realms')

  def behaviors = (@title = '16 Behaviors')

  def answer
    @type_path = params[:id]
    @title = "Answer: #{@type_path}"
    @behaviors = @type_path.split('-').filter_map { |s| Behavior.find_by(tla: s) }
    @valid = @behaviors.map(&:realm).uniq.count == 4 && @behaviors.map(&:attitude).uniq.count == 4
  end
end
