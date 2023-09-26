class Behavior < Concept

  def initialize(string)
    @symbol = string
    @verb = Verb.send(string.first)
    @realm = Realm.send(string.second)
    @noun = Noun.send(string.third)
  end
  attr_reader :symbol, :verb, :realm, :noun

  def generic_behavior; @verb + @noun; end

  #TODO replace with capture missing and send to generic
  def description; generic_behavior.description; end
  def short_description; generic_behavior.short_description; end
  def inline_description; generic_behavior.inline_description; end
  def season; generic_behavior.season; end
  def at; generic_behavior.at; end
    def day; generic_behavior.day; end
  def time; generic_behavior.time; end
  def problems; generic_behavior.problems; end

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
  def tls2; tls.switch('E', 'I'); end
  def tls3; tls.switch('J', 'P'); end
  def mbti; tls.is_tls? ? tls : realm.mbti; end
  def jungian; tls.is_tls? ? tls.to_fa : [tls2,tls3].map(&:to_fa).or; end

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

end
