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

  def <=>(other) = action.index <=> other.action.index

  def moods = action.moods.add(realm)

  WORDS =
    { iFp: 'listen to songs',
      eFp: 'sing',
      eFj: 'create moral stories',
      iFj: 'listen to moral stories',
      iSp: 'eat sweets',
      eSp: 'gather/bake sweets',
      eSj: 'create nutritious meals',
      iSj: 'eat nutritious meals',
      iNp: 'remember colorful pictures',
      eNp: 'paint colorful pictures',
      eNj: 'create scientific theories',
      iNj: 'remember scientific theories',
      iTp: 'sell toys',
      eTp: 'buy toys',
      eTj: 'buy useful tools',
      iTj: 'sell useful tools' }.freeze
  def wise = WORDS[symbol] || super

  OTHERS =
    { iFp: 'sung by others',
      iSp: 'gathered/baked by others',
      iNp: 'painted by others',
      iTp: 'bought by others' }.freeze
  def others
    case action
    when Action.ep, Action.ej
      'for others'
    when Action.ij
      'created by others'
    else
      OTHERS[symbol]
    end
  end

  def long_others = [string.colon, wise, others.wrap].to_phrase
  def long_myself = long_others.gsub('others', 'myself')
end
