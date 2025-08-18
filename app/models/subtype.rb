# frozen_string_literal: true

class Subtype
  def initialize(string)
    @string = string
    @behavior = Behavior.find_by(tla: string.chop)
    @index = string.last.to_i + 1
    @ordinal = @index.ordinalize
  end
  attr_reader :behavior, :ordinal, :index

  def inspect = behavior.tla + ordinal

  def ordinal_word = %w[first second third last][@index -1]
  def conscious? = index < 3

  %i[top? bottom? advice something do_something timed_action best_time <=> first? second? third? fourth? tla episode
     flip flop opposite adjective side bipolar].each do |meth|
    delegate meth, to: :behavior
  end

  def goal = "#{ordinal}: #{behavior.goal}"
end
