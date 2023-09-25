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

  def tls; [verb, realm, noun].map(&:mbti).join; end
  def tls2
    if tls.match(/E.P/) then return tls.gsub('E', 'I'); end
    if tls.match(/I.P/) then return tls.gsub('I', 'E'); end
    if tls.match(/I.J/) then return tls.gsub('J', 'P'); end
    if tls.match(/E.J/) then return tls.gsub('E', 'I'); end
  end
  def mbti; tls.is_mbti? ? tls : tls2 + " (closest match)"; end

  def self.find_by_mbti(tls); all.find{|b| b.mbti == tls}; end

  def <=>(other); self.generic_behavior.index <=> other.generic_behavior.index; end

  def unwanted; "craving #{name} behaviors"; end
  def wanted; "unable to #{opposite.name}"; end

  def opposite; Behavior.send("#{verb.other.symbol}#{realm.symbol}#{noun.other.symbol}"); end
  def horizontal; Behavior.send("#{verb.symbol}#{realm.symbol}#{noun.other.symbol}"); end
  def vertical; Behavior.send("#{verb.other.symbol}#{realm.symbol}#{noun.symbol}"); end

  def next; realm + generic_behavior.next; end
  def previous; realm + generic_behavior.previous; end

  def problem_names; [noun.problem, realm, verb.problem].map(&:name).to_phrase; end

  def mastered
    case generic_behavior.index
    when 0
      words.ing
    when 1
      [verb.previous.word.ing, "and", verb.word.ing, realm.word, noun.word].to_phrase
    when 2
      [Verb.last.word.ing, "and", Verb.first.word.ing, realm.word, Noun.first.word, "and", *words.ing].to_phrase
    when 3
      [Verb.last.word.ing, "and", Verb.first.word.ing, realm.word, Noun.first.word, "and", Noun.last.word].to_phrase
    end
  end
end
