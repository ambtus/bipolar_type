# frozen_string_literal: true

class Subtype
  def initialize(string)
    @string = string
    @behavior = Behavior.find_by(tla: string.chop)
    @index = string.last.to_i
  end
  attr_reader :behavior, :index

  def number = index + 1
  def ordinal = number.ordinalize
  def ordinal_word = %w[first second third fourth][index]
  def jungian = %w[dominant auxiliary tertiary inferior][index]

  def inspect = behavior.tla + ordinal
  def goal = "#{ordinal}: #{behavior.goal}"

  def opposite_ordinal_word = %w[last third second first][index]
  def opposite_ordinal = %w[4th 3rd 2nd 1st][index]
  def episode = "#{opposite_ordinal}: #{behavior.episode.downcase}"

  def episode_difficulty = ['easy', 'relatively easy', 'relatively hard', 'hard'][index]

  %i[top? bottom? first? second? third? last? <=>
     flip flop opposite tla adjective adverb
     advice something do_something timed_action time best_time
     attitude bipolar season execute what].each do |meth|
    delegate meth, to: :behavior
  end
end
