# frozen_string_literal: true

class Type
  def initialize(string)
    @realm_string = string
    @realms = string.chars.collect { |s| Realm.find(s) }
    @realms.uniq.check_constraints(Realm, 4, 4)
  end
  attr_reader :realm_string, :realms
  alias path :realm_string
  alias inspect :realm_string

  ALL = Realm.all.permutation(4).collect do |realms|
    Type.new(realms.map(&:symbol).join)
  end

  class << self
    def all = ALL
    def each(&) = ALL.each(&)
    def title = [all.count, name.pluralize].to_phrase
    def find(string) = all.find { |t| t.realm_string == string }

    def my_path = 'SFNT'
    # for tests, just needs to be different.
    def your_path = my_path.reverse
    def my_type = find(my_path)
    def your_type = find(your_path)
  end

  def problems = realms.add(Attitude.all)
  def title = "#{path[0, 2]}P/#{path[2, 2]}J"
end
