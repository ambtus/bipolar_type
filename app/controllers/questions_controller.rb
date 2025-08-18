# frozen_string_literal: true

class QuestionsController < ApplicationController
  def index
    @title = '40 Questions'
    @pairs = Behavior.pairs
    @line_number = params[:n].blank? ? 0 : params[:n].to_i
    render 'questions'
  end

  def create
    redirect_to answer_path('nil') and return if params[:q].blank?

    choices = params[:q].values
    Rails.logger.debug { choices }
    counts = Hash.new(0)
    choices.each { |v| counts[v] += 1 }
    Rails.logger.debug { counts }
    sorted = counts.sort_by { |_, value| value }
    Rails.logger.debug { sorted }
    preferences = sorted.map(&:first)
    dominant = preferences.pop
    free = Behavior.without([dominant]).map(&:tla) & preferences
    redirect_to answer_path(dominant) and return if free.blank?

    auxiliary = free.pop
    now_free = free & Behavior.without([auxiliary]).map(&:tla)
    redirect_to answer_path([dominant, auxiliary].join('-')) and return if now_free.blank?

    tertiary = now_free.pop
    inferior = Behavior.without([dominant, auxiliary, tertiary]).map(&:tla).first

    redirect_to answer_path [dominant, auxiliary, tertiary, inferior].compact.join('-')
  end
end
