class Behavior < Concept

  def initialize(string)
    @symbol = string
    @verb = Verb.send(string.first)
    @realm = Realm.send(string.second)
    @noun = Noun.send(string.third)
  end
  attr_reader :symbol, :verb, :realm, :noun


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

  def generic_behavior; @verb + @noun; end

  def opposite; realm + generic_beahavior.opposite; end
  def next; realm + generic_behavior.next; end
  def previous; realm + generic_behavior.previous; end

  def method_missing(meth, *arguments, &block)
    if generic_behavior.respond_to?(meth)
      generic_behavior.send(meth, *arguments, &block)
    else
      super
    end
  end

  def tls; [verb, realm, noun].map(&:mbti).join; end
  def tls2; tls.switch('E', 'I'); end
  def jungian; tls.is_tls? ? tls.to_fa : tls2.to_fa+'?'; end
  def mbti; tls.is_tls? ? tls : realm.mbti; end

  def self.find_by_mbti(tls); all.find{|b| b.mbti == tls}; end

  def behavior_path; "behaviors/#{symbol}"; end
end
