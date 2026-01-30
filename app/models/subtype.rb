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

  def <=>(other) = mood.index <=> other.mood.index

  delegate :horizontal?, to: :mood
  delegate :accept, :change, :appear, :energy, to: :realm

  def similars = realm.subtypes + mood.subtypes

  def opposite = mood.opposite + realm
  def siblings = mood.siblings.add(realm)

  def self.types = all.select { |x| x.mood.vertical? }

  def behaviors = mood.sibling_actions.add(realm)

  def wings = mood.siblings.add(realm)

  Action.each do |action|
    define_method(action.symbol) { realm + action }
  end

  def state = [string.colon, wise].to_phrase
  def foolish = "#{realm.wise.ly} #{mood.foolish}"
  def episode = "#{realm.wise} #{mood.episode}"
  def bipolar = [string.colon, episode].to_phrase

  def description = [realm.adverb, mood.wise].to_phrase

  WORDS = {
     Fp: 'expressive music',
      Fj: 'meaningful words',
      Tp: 'liquid cash',
      Tj: 'secured credit',
      Np: 'changing colors ',
      Nj: 'stable outlines',
      Sp: 'sweet carbs',
      Sj: 'savory proteins'
  }.freeze

  def wise = horizontal? ? WORDS[symbol] : (mood.reverse? ? realm.accept : realm.change)
end
