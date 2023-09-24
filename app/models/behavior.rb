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

  def <=>(other); self.generic_behavior.index <=> other.generic_behavior.index; end

  def bad; "I #{verb.word} too much #{realm.word} #{noun.word}."; end

  def good; "I don’t #{verb.other.word} enough #{realm.word} #{noun.other.word}."; end

  def opposite; Behavior.send("#{verb.other.symbol}#{realm.symbol}#{noun.other.symbol}"); end
  def horizontal; Behavior.send("#{verb.symbol}#{realm.symbol}#{noun.other.symbol}"); end
  def vertical; Behavior.send("#{verb.other.symbol}#{realm.symbol}#{noun.symbol}"); end

  def problems; [GenericProblem.all[generic_behavior.index], GenericProblem.all[(generic_behavior.index-1)%4]]; end
  def problem_names; [realm.name, problems.map(&:name).and].to_phrase; end

end
