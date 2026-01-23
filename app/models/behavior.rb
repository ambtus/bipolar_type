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

  def wise
    { iSp: 'eat things that taste good',
      eSp: 'cook things that smell good',
      eSj: 'cook meals that are nutritious',
      iSj: 'eat meals that are nutritious',
      iNp: 'remember things that look good',
      eNp: 'create things that look good',
      eNj: 'create theories that are true',
      iNj: 'remember theories that are true',
      iTp: 'sell things that feel good',
      eTp: 'buy things that feel good',
      eTj: 'buy tools that are useful',
      iTj: 'sell tools that are useful',
      iFp: 'listen to things that sound good',
      eFp: 'say things that sound good',
      eFj: 'tell stories that are moral',
      iFj: 'listen to stories that are moral',
    }[symbol] || super
  end

end
