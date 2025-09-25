# frozen_string_literal: true

class Behavior < Concept
  SYMBOLS = Realm.all.collect do |realm|
    Attitude.all.collect do |attitude|
      (attitude.string.first + realm.string + attitude.string.second).to_sym
    end
  end.flatten

  def tla = symbol.to_s.downcase
  def link = tla.upcase

  ALL = SYMBOLS.collect { |symbol| new symbol }

  def realm = Realm.find(string.second)
  def attitude = Attitude.find(string.first + string.third)

  %i[top? bottom? left? right? first? second? third? last?
     season seasonal time_of_day previous react time bad worse stop
     execute which goal].each do |meth|
    delegate meth, to: :attitude
  end

  %i[adjective adverb foci internals externals output].each do |meth|
    delegate meth, to: :realm
  end

  def do_something = [execute, adjective, which].to_phrase

  def bipolar = [adjective, attitude.bipolar].to_phrase
  def episode = [seasonal, flop.attitude.bipolar].to_phrase.titleize

  def self.find_by(hash) = ALL.find { |s| s.tla == hash[:tla].to_s }
  def self.tlas = ALL.map(&:tla)

  def opposite = realm + attitude.opposite
  def flip = realm + attitude.flip
  def flop = realm + attitude.flop

  def self.pairs = ALL.flat_map { |b| b.siblings.collect { |s| [b, s] } }.map(&:sort).uniq
  def siblings = [flip, flop, *realm_siblings]
  def realm_siblings = ALL.select { |b| b.attitude == attitude && b != self }

  def replace_realm(r) = ALL.find { |b| b.attitude == attitude && b.realm == r }

  def words = File.readlines("app/words/#{tla}", chomp: true).first
  def long = "#{words} #{time}"
end
