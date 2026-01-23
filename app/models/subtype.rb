# frozen_string_literal: true

class Subtype < Concept
  SYMBOLS = Realm.all.collect do |realm|
    Mood.all.collect do |mood|
      mood.horizontal? ? (realm.string + mood.string) : (mood.string + realm.string)
    end.map(&:to_sym)
  end.flatten
  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def realm = Realm.all.find { |x| string.match x.string }
  def mood = Mood.all.find { |x| string.match x.string }

  delegate :horizontal?, to: :mood


  def opposite = realm + mood.opposite

  def self.types = all.select { |x| x.mood.vertical? }

  def behaviors = mood.sibling_actions.add(realm)

  Action.each do |action|
    define_method(action.symbol) { realm + action }
  end

  def wise = [realm.wise.ly, mood.wise].to_phrase
  def foolish = [realm.wise.ly, mood.foolish].to_phrase

  def state = [string.colon, name].to_phrase
  def bipolar = [string.colon, foolish].to_phrase
end
