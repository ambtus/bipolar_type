# frozen_string_literal: true

class Type
  def initialize(string)
    @behaviors = string.split('•').collect { |s| Behavior.find_by(tla: s) }
    @behaviors.map(&:realm).uniq.check_constraints(Realm, 4, 4)
    @behaviors.map(&:attitude).uniq.check_constraints(Attitude, 4, 4)
  end
  attr_reader :behaviors

  def tlas = behaviors.map(&:tla)
  def title = tlas.join('•')
  alias inspect :title

  class << self
    def my_path = 'ifp•enj•etp•isj'
    def my_type = Type.new(my_path)
    # for cucumber tests, just needs to be different.
    def your_path = my_type.behaviors.reverse.map { |x| x.opposite.tla }.join('•')
    def your_type = Type.new(your_path)
    # for visual tests, want to hit all sixteen subtypes
    def next_path = my_type.behaviors.rotate.map { |x| x.flip.tla }.join('•')
    def other_path = my_type.behaviors.reverse.rotate.map { |x| x.flop.tla }.join('•')
  end

  def subtypes = behaviors.each_with_index.collect { |b, i| Subtype.new(b.tla + i.to_s) }

  def tops = [subtypes.find(&:second?), subtypes.find(&:third?)]
  def bottoms = [subtypes.find(&:first?), subtypes.find(&:fourth?)]
end
