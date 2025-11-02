# frozen_string_literal: true

class Type < Concept
  SYMBOLS = Realm.strings.permutation(4).collect do |realms|
    [
     "e#{realms[0, 2].join}p/i#{realms[2, 2].join}j",
     "e#{realms[2, 2].join}j/i#{realms[0, 2].join}p",
     "i#{realms[0, 2].join}p/e#{realms[2, 2].join}j",
     "i#{realms[2, 2].join}j/e#{realms[0, 2].join}p",
    ]
  end.flatten.map(&:to_sym)

  ALL = SYMBOLS.collect { |symbol| new symbol }

  alias inspect :string

  class << self
    def with(subtypes) = ALL.select { |s| (subtypes - s.subtypes).blank? }.sort
    def my_path = 'iSFp/eTNj'
    def my_type = find(my_path)
    # for cucumber tests; just needs to be different
    def your_type = my_type.siblings.first
    def your_path = your_type.path
    # for visual tests
    def next_type = my_type.siblings.second
    def next_path = next_type.path
    def other_type = my_type.siblings.third
    def other_path = other_type.path
  end

  def subtypes = string.delete('/').scan(/../).collect { |x| Subtype.find(x) }
  def word = subtypes.map(&:word).join('=>')
  def behaviors = subtypes.map(&:behaviors).flatten

  def <=>(other) = attitude <=> other.attitude

  def family = Type.select{|x| x.subtypes.sort == self.subtypes.sort}.sort
  def siblings = family.without(self)

  def attitude = Attitude.send(string.first + string.fourth)
  def episode_behavior = subtypes.first.realm + attitude

  %i[episode aka episode_type].each do |meth|
    delegate meth, to: :attitude
  end

  def bp1? = attitude.bp1?
  def balance = bp1? ? 'left' : 'right'
  def excess = bp1? ? 'right' : 'left'

  Mood::SYMBOLS.each do |sym|
    define_method(sym) { subtypes.find { |x| x.mood.symbol == sym } }
  end

end
