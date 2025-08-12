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

  def self.without(string)
    subtypes = string.scan(/.../).collect { |tla| find_by(tla: tla) }
    Rails.logger.debug { "subtypes: #{subtypes}" }
    realms = subtypes.map(&:realm)
    attitudes = subtypes.map(&:attitude)
    all.reject { |s| realms.include?(s.realm) || attitudes.include?(s.attitude) }
  end

  %i[top? left? diagonal? first? second? third? last? time season previous element react].each do |meth|
    delegate meth, to: :attitude
  end

  %i[adjective adverb letter foci organ].each do |meth|
    delegate meth, to: :realm
  end

  def something = left? ? 'energy' : 'strength'
  def execute = top? ? 'use' : 'get'
  def do_something = [execute, adjective, something].to_phrase
  def anything = [adjective, something].to_phrase

  def bipolar = [adjective, attitude.bipolar].to_phrase
  def bad = [adverb, attitude.bad].to_phrase
  def worse = [adverb, attitude.worse].to_phrase
  def episode = [opposite.season, bipolar].to_phrase.titleize
  alias link :episode

  def episode(index=0)
    return "My worst regret is #{do_something.ing} despite not being #{worse}." if index.zero?
    return "I also regret having #{do_something.en} when #{bad}." if index == 1
    "I usually stop #{do_something.ing} when I become bored."
  end

  def tla = [top? ? 'U' : 'G', letter, left? ? 'E' : 'S'].join
  def self.find_by(hash) = ALL.find { |s| s.tla == hash[:tla].to_s }

  def opposite = realm + attitude.opposite
  def flip = realm + attitude.flip
  def flop = realm + attitude.flop

  def lines = File.foreach("app/views/words/#{tla}", chomp: true)
end
