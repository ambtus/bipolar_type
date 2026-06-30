# frozen_string_literal: true

class Type
  def initialize(string)
    @attitudes = string.chars.collect { |s| Attitude.find(s.downcase) }
    @attitudes.check_constraints(Attitude, 4, 4)
  end
  attr_reader :attitudes

  def path = attitudes.map(&:string).join
  def title = path.upcase
  alias inspect :title

  def behaviors = attitudes.add(Realm.linear)

  class << self
    def my_path = 'ofie'
    def my_type = Type.new(my_path)
    # for cucumber tests, just needs to be different.
    def your_path = my_path.chars.rotate.join
    def your_type = Type.new(your_path)
    # for visual tests, want to hit all sixteen subtypes
    def next_path = your_path.chars.rotate.join
    def other_path = next_path.chars.rotate.join
  end


end
