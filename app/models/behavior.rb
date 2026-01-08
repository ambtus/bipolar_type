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

  def siblings = realm.behaviors.without(self)
  def similars = action.behaviors.without(self)

  delegate :<=>, to: :action

  %i[previous next opposite flip flop].each do |sym|
    define_method(sym) { realm + action.send(sym) }
  end

  def types = Type.select { |x| x.donts.include?(self) }
  def moods = action.moods.add(realm)

  def examples = File.readlines("examples/#{string}", chomp: true)

  def generic = [action.verb, realm.generic, action.noun].to_phrase

  def focus = ['focus on', action.adjective, realm.generic, action.focus].to_phrase

  def first = [realm.refuel, 'escape from', 'confront', realm.rest][action.index]

  def second
    ['that do not make you feel anxious', 'that make you feel anxious', 'that irritate you',
     'that do not irritate you'][action.index]
  end

  def technical = [first, realm.externals, second].to_phrase

  def prefix(green: true)
    case green
    when true
      'do'
    when false
      'don’t'
    else
      ''
    end
  end

  def title(green: nil) = [string.colon, prefix(green: green), generic].to_phrase

  def specific = realm.send(action.symbol)
end
