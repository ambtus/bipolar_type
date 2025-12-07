# frozen_string_literal: true

class Type < Concept
  SYMBOLS = Realm.strings.permutation(4).collect do |realms|
    [
      "e#{realms[0, 2].join}p/i#{realms[2, 2].join}j",
      "e#{realms[2, 2].join}j/i#{realms[0, 2].join}p",
      "i#{realms[0, 2].join}p/e#{realms[2, 2].join}j",
      "i#{realms[2, 2].join}j/e#{realms[0, 2].join}p"
    ]
  end.flatten.map(&:to_sym)

  ALL = SYMBOLS.collect { |symbol| new symbol }

  alias inspect :string
  alias title :string

  class << self
    def with(subtypes) = ALL.select { |s| (subtypes - s.subtypes).blank? }.sort

    def title(subtypes)
      if subtypes.present?
        "#{Type.with(subtypes).count} BipolarTypes with #{subtypes.and}"
      else
        "#{all.count} BipolarTypes"
      end
    end

    def my_path = 'iSFp/eTNj'
    def my_type = find(my_path)
    # for cucumber tests; just needs to be different
    def your_path = 'eFSp/iNTj'
    def your_type = find(your_path)
    # for visual tests
    def next_type = my_type.siblings.second
    def next_path = next_type.path
    def other_type = your_type.siblings.third
    def other_path = other_type.path
  end

  def subtypes = string.delete('/').scan(/../).collect { |x| Subtype.find(x) }
  def behaviors = subtypes.map(&:behaviors).flatten

  def <=>(other) = attitude <=> other.attitude

  def family = Type.select { |x| x.subtypes.sort == subtypes.sort }.sort
  def siblings = family.without(self)

  def attitude = Attitude.send(string.first + string.fourth)
  def episode_behavior = subtypes.first.realm + attitude
  def dominant = subtypes.second.realm + attitude

  %i[aka episode_type].each do |meth|
    delegate meth, to: :attitude
  end

  def episode = attitude.episode.insert_word(subtypes.first.realm.short_words)

  def other_episode = attitude.opposite.episode.insert_word(subtypes.third.realm.short)

  delegate :bp1?, to: :attitude
  def balance = bp1? ? 'left' : 'right'
  def excess = bp1? ? 'right' : 'left'

  Mood::SYMBOLS.each do |sym|
    define_method(sym) { subtypes.find { |x| x.mood.symbol == sym } }
  end
end
