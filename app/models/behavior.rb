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

  def self.without(array)
    behaviors = array.collect { |tla| find_by(tla: tla) }
    Rails.logger.debug { "behaviors: #{behaviors}" }
    realms = behaviors.map(&:realm)
    attitudes = behaviors.map(&:attitude)
    all.reject { |s| realms.include?(s.realm) || attitudes.include?(s.attitude) }
  end

  %i[top? bottom? left? first? second? third? fourth? season previous react time].each do |meth|
    delegate meth, to: :attitude
  end

  %i[adjective adverb foci organ].each do |meth|
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

  def tla = [top? ? 'e' : 'i', realm.string.downcase, left? ? 'p' : 'j'].join
  def self.find_by(hash) = ALL.find { |s| s.tla == hash[:tla].to_s }

  def opposite = realm + attitude.opposite
  def flip = realm + attitude.flip
  def flop = realm + attitude.flop

  def link = tla.upcase

  def what = top? ? "stressful #{foci}" : "your #{organ}"
  def goal = [attitude.goal, what].to_phrase

  def lines = File.foreach("app/words/#{tla}", chomp: true)

  def timed_action = [do_something, time].to_phrase
  def advice = lines.first
end
