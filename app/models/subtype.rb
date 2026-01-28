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
  delegate :change, :accept, :appear, :appears, :resources, :good, :bad, :organs, :persona, :adjective, :adverb,
:energy, to: :realm

  def opposite = realm + mood.opposite

  def siblings = Mood.all.add(realm) + Realm.all.add(mood)

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

  WORDS =
    { Fp: 'music',
      eF: 'tell via',
      Fj: 'words',
      iF: 'listen to',
      Tp: 'cash',
      eT: 'pay via',
      Tj: 'credit',
      iT: 'earn',
      Np: 'colorful details',
      eN: 'show via',
      Nj: 'general shapes',
      iN: 'see',
      Sp: 'carbs',
      eS: 'provide',
      Sj: 'protein',
      iS: 'eat' }.freeze
  def wise = WORDS[symbol] || super
  def short = horizontal? ? wise.last_word : wise.first_word
  def title = "#{string}: #{short}"
end
