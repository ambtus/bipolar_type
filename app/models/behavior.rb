# frozen_string_literal: true

class Behavior < Concept
  SYMBOLS = Realm.all.collect do |realm|
    Attitude.all.collect do |attitude|
      (attitude.string + realm.string).to_sym
    end
  end.flatten

  def tla = symbol.to_s
  def link = tla.upcase

  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |thing| thing.symbol == sym } }
  end

  def realm = Realm.find(string.second)
  def attitude = Attitude.find(string.first)
  def name = [realm.name, attitude.name].to_phrase

  def self.without(array)
    behaviors = array.collect { |tla| find_by(tla: tla) }
    Rails.logger.debug { "behaviors: #{behaviors}" }
    realms = behaviors.map(&:realm)
    attitudes = behaviors.map(&:attitude)
    all.reject { |s| realms.include?(s.realm) || attitudes.include?(s.attitude) }
  end

  %i[top? bottom? left? first? second? third? last? external?
     season seasonal time_of_day previous react time bad worse stop
     execute which goal].each do |meth|
    delegate meth, to: :attitude
  end

  %i[adjective adverb foci organ].each do |meth|
    delegate meth, to: :realm
  end

  def something = [adjective, which].to_phrase
  def do_something = [execute, adjective, which].to_phrase

  def bipolar = [adjective, attitude.bipolar].to_phrase
  def episode = [flip.seasonal, realm.adjective, opposite.attitude.bipolar].to_phrase.titleize

  def what = top? ? realm.top : realm.bottom
  def goal = [react, 'and', attitude.goal, 'their', what].to_phrase
  def my_goal = goal.make_mine

  def self.find_by(hash) = ALL.find { |s| s.tla == hash[:tla].to_s }
  def self.tlas = ALL.map(&:tla)

  def opposite = realm + attitude.opposite
  def flip = realm + attitude.flip
  def flop = realm + attitude.flop
  def siblings = [flip, flop]
  def all_siblings = siblings + realm_siblings
  def realm_siblings = ALL.select { |b| b.attitude == attitude && b != self }

  def self.pairs = ALL.flat_map { |b| b.all_siblings.collect { |s| [b, s] } }.map(&:sort).uniq

  def replace_realm(r) = ALL.find { |b| b.attitude == attitude && b.realm == r }

  def description
    lines = File.readlines("app/descriptions/#{tla}", chomp: true)
    if lines.join.match(', ')
      lines.join('; ')
    else
      lines.join(', ')
    end
  end


end
