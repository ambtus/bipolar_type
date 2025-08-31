# frozen_string_literal: true

class QuestionsController < ApplicationController
  def index
    @title = '40 Questions'
    @pairs = Behavior.pairs
    render 'questions'
  end

  def show
    @title = params[:id]
    @sets = sets(@title.chars.values_at(0, 1, 4, 5).collect { |c| Realm.find(c.downcase) })
    if params[:format]
      @set = @sets[params[:format].to_i]
      render 'Q2' and return
    end
    render 'Q1'
  end

  def create
    @preferences = sort(params[:q].try(&:values))
    Rails.logger.debug { "preferences: #{@preferences}" }
    if @preferences.blank?
      redirect_to answer_path('nil')
    else
      @functions = []
      4.times { update_p_and_f }
      redirect_to answer_path @functions.join('-')
    end
  end

  private

  def sets(realms)
    [realms,
     realms.values_at(0, 1, 3, 2),
     realms.values_at(1, 0, 2, 3),
     realms.values_at(1, 0, 3, 2)].collect { |set| set.add(Attitude.all) }
  end

  def update_p_and_f
    new = @preferences.pop
    if new.blank?
      possibles = Behavior.without(@functions).map(&:tla)
      @functions << possibles.first if possibles.size == 1
    else
      @functions << new
      @preferences &= Behavior.without(@functions).map(&:tla)
    end
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
