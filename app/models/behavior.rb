# frozen_string_literal: true

class Behavior < Concept
  SYMBOLS = Realm.all.collect do |realm|
    Attitude.all.collect do |attitude|
      (attitude.string.first + realm.string + attitude.string.second).to_sym
    end
  end.flatten


  ALL = SYMBOLS.collect { |symbol| new symbol }

  def realm = Realm.find(string.second)
  def attitude = Attitude.find(string.first + string.third)
  def <=>(other) = attitude.index <=> other.attitude.index

  %i[top? bottom? left? right? drugs
     season seasonal previous react time bad worse stop
     execute which goal].each do |meth|
    delegate meth, to: :attitude
  end

  %i[adjective adverb foci internals externals output intake].each do |meth|
    delegate meth, to: :realm
  end

  def generic = top? ? output : intake

  def do_something = [execute, adjective, which].to_phrase
  alias name :do_something

  def bipolar = [adjective, attitude.bipolar].to_phrase
  def episode = [seasonal, flop.attitude.bipolar].to_phrase.titleize

  def opposite = realm + attitude.opposite
  def flip = realm + attitude.flip
  def flop = realm + attitude.flop

  def lines = File.readlines("words/#{symbol.downcase}", chomp: true)
  def link = lines.first
end
