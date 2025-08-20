# frozen_string_literal: true

class QuestionsController < ApplicationController
  def index
    @title = '40 Questions'
    @pairs = Behavior.pairs
    @line_number = if params[:n].blank?
                     0
                   else
                     params[:n].to_i
                   end
    render 'questions'
  end

  def create
    @preferences = sort(params[:q].try(&:values))
    Rails.logger.debug { "preferences: #{@preferences}" }
    if @preferences.blank?
      redirect_to answer_path('nil')
    else

      @functions = []
      4.times { update_p_and_f }
      derive_missing if @functions.size == 3
      redirect_to answer_path @functions.join('-')
    end
  end

  private

  def derive_missing
    leftovers = Behavior.without(@functions)
    return unless leftovers.size == 1

    @functions << leftovers.first.tla
  end

  def update_p_and_f
    @functions << @preferences.pop
    @functions.compact!
    dups = Behavior.without(@functions) & @preferences
    @preferences.delete(dups)
    Rails.logger.debug { "functions: #{@functions}" }
  end

  def sort(values)
    return [] if values.blank?

    counts = Hash.new(0)
    values.each { |v| counts[v] += 1 }
    sorted = counts.sort_by { |_, value| value }
    sorted.map(&:first)
  end
end
