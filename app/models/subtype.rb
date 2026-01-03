# frozen_string_literal: true

class Subtype < Concept
  SYMBOLS = Realm.pp_order.collect do |realm|
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

  def self.types = all.select { |x| x.mood.vertical? }

  %i[previous next opposite flip flop].each do |sym|
    define_method(sym) { realm + mood.send(sym) }
  end

  def sibling_actions = Action.all.select { |x| x.path.match? mood.path }

  def behaviors = sibling_actions.add(realm)

  Action.each do |action|
    define_method(action.symbol) { realm + action }
  end

  def manic? = (mood == Mood.e)

  def generic = mood.generic.words.insert(-2, realm.generic).to_phrase

  def title = [string.colon, generic].to_phrase
end
