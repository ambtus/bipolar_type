# frozen_string_literal: true

class Behavior < Concept
  SYMBOLS = Realm.all.collect do |realm|
    Action.all.collect do |action|
      (action.string.first + realm.string + action.string.second).to_sym
    end
  end.flatten

  ALL = SYMBOLS.collect { |symbol| new symbol }
  SYMBOLS.each do |sym|
    define_singleton_method(sym) { ALL.find { |s| s.symbol == sym } }
  end

  def realm = Realm.find(string.second)
  def action = Action.find(string.first + string.third)


  def foolish = Mood.find(string.first).foolish

  def <=>(other) = action.index <=> other.action.index

  def moods = action.moods.add(realm)

  def similars = realm.behaviors + action.behaviors

  def opposite = action.opposite + realm
  def flop = action.flop + realm
  def flip = action.flip + realm
  def siblings = action.siblings.add(realm)

  WORDS =
    { iFp: 'listen to music',
      eFp: 'make new friends',
      eFj: 'influence people',
      iFj: 'listen to stories',
      iSp: 'eat breakfast carbs',
      eSp: 'visit new places',
      eSj: 'cook or clean homes',
      iSj: 'eat dinner proteins',
      iNp: 'watch the news',
      eNp: 'make new plans',
      eNj: 'improve theories',
      iNj: 'watch the results',
      iTp: 'earn spending money',
      eTp: 'buy new tools',
      eTj: 'upgrade shelters',
      iTj: 'earn repayments' }.freeze
  def wise = WORDS[symbol] || super

  def foolish = action.foolish.words.insert(-2, realm.wise).to_phrase

  def aka_verb = [action.wise, realm.adverb].to_phrase
  def aka_noun = [realm.wise, action.wise.to_noun].to_phrase
end
