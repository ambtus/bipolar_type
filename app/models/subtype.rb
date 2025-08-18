# frozen_string_literal: true

class Subtype
  def initialize(string)
    @string = string
    @behavior = Behavior.find_by(tla: string.chop)
    @index = string.last.to_i
    @ordinal = (@index + 1).ordinalize
  end
  attr_reader :behavior, :ordinal, :index

  def inspect = behavior.tla + ordinal

  def ordinal_word = %w[first second third last][@index]

  def conscious? = index < 2

  %i[top? bottom? advice something do_something timed_action best_time <=> first? second? third? fourth? tla episode
     flip flop opposite adjective side].each do |meth|
    delegate meth, to: :behavior
  end

  def age = %w[child adolescent adult elder][index]

  def goal = "#{ordinal}: #{behavior.goal}"
end
