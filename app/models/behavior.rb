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

end
