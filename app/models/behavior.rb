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

  def opposite = action.opposite + realm
  def flop = action.flop + realm
  def flip = action.flip + realm

  WORDS =
    { iFp: 'listen to music',
      eFp: 'use intonation',
      eFj: 'use words',
      iFj: 'listen to words',
      iSp: 'eat carbs',
      eSp: 'run marathons',
      eSj: 'lift weights',
      iSj: 'eat protein',
      iNp: 'watch the news',
      eNp: 'paint pictures',
      eNj: 'use outlines',
      iNj: 'watch the results',
      iTp: 'earn cash',
      eTp: 'pay cash upfront',
      eTj: 'use credit',
      iTj: 'earn repayments' }.freeze
  def wise = WORDS[symbol] || super

  def wrapped = "#{string} #{wise.wrap}"

  def episode = action.episode.words.insert(-2, realm.wise).to_phrase

end
