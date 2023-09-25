class Behavior < Concept

  def initialize(string)
    @symbol = string
    @verb = Verb.send(string.first)
    @realm = Realm.send(string.second)
    @noun = Noun.send(string.third)
  end
  attr_reader :symbol, :verb, :realm, :noun

  def generic_behavior; @verb + @noun; end

  ########
  ALL = GenericBehavior::SYMBOLS.collect do |phrase|
          Realm::SYMBOLS.collect do |realm|
            self.new [phrase.first, realm, phrase.second].join
          end
        end.flatten
  SYMBOLS = ALL.map(&:symbol)
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def words; [verb.word, realm.word, noun.word].to_phrase; end

  def mbti; [verb, realm, noun].map(&:mbti).join; end

  def self.find_by_mbti(tls); all.find{|b| b.mbti == tls}; end

  def <=>(other); self.generic_behavior.index <=> other.generic_behavior.index; end

  def unwanted; "I #{name} too much."; end
  def wanted; "I don’t #{opposite.name} enough."; end

  def opposite; Behavior.send("#{verb.other.symbol}#{realm.symbol}#{noun.other.symbol}"); end
  def horizontal; Behavior.send("#{verb.symbol}#{realm.symbol}#{noun.other.symbol}"); end
  def vertical; Behavior.send("#{verb.other.symbol}#{realm.symbol}#{noun.symbol}"); end

  def next; realm + generic_behavior.next; end

  def problem_names; [noun.problem, realm, verb.problem].map(&:name).to_phrase; end

end
