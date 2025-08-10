# frozen_string_literal: true

class Subtype < Concept
  SYMBOLS = Realm.all.collect do |realm|
    Attitude.all.collect do |attitude|
      (attitude.string.first + realm.string + attitude.string.second).to_sym
    end
  end.flatten

  ALL = SYMBOLS.collect { |symbol| new symbol }

  def realm = Realm.find(string.second)
  def attitude = Attitude.find(string.first + string.third)

  def self.without(string)
    subtypes = string.scan(/.../).collect { |tla| Subtype.find_by(tla: tla) }
    Rails.logger.debug { "subtypes: #{subtypes}" }
    realms = subtypes.map(&:realm)
    attitudes = subtypes.map(&:attitude)
    Subtype.all.reject { |s| realms.include?(s.realm) || attitudes.include?(s.attitude) }
  end

  %i[bad badness worse top? left? diagonal? first? second? last? time season previous element react].each do |meth|
    delegate meth, to: :attitude
  end

  %i[adjective adverb letter foci organ].each do |meth|
    delegate meth, to: :realm
  end

  def do_something = [top? ? 'use' : 'get', adjective, left? ? 'energy' : 'strength'].to_phrase

  def tla = [top? ? 'U' : 'G', letter, left? ? 'E' : 'S'].join
  def self.find_by(hash) = ALL.find { |s| s.tla == hash[:tla].to_s }

  def link = [adjective, element].to_phrase

  def opposite = realm + attitude.opposite
  def flip = realm + attitude.flip
  def flop = realm + attitude.flop

  def timespan = "#{previous.season}/#{season} #{time}"
  def what = top? ? foci : "your #{organ}"
  def goal = [attitude.goal, what].to_phrase

  def lines = File.foreach("app/views/words/_#{string}", chomp: true)
end
