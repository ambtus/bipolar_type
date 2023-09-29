class Behavior < Concept
  def generic?; false; end

  def initialize(string)
    @symbol = string
    @verb = Verb.send(string.first)
    @realm = Realm.send(string.second)
    @noun = Noun.send(string.third)
  end
  attr_reader :symbol, :verb, :realm, :noun

  def path; Rails.application.routes.url_helpers.behavior_path(self.symbol); end
  def example_path; "behaviors/#{symbol}"; end
  def answer_path; Rails.application.routes.url_helpers.answer_path(Answer.jump_path(self)); end

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

  def instead; realm + generic_behavior.previous; end
  def more; realm + generic_behavior.next; end
  def less; realm + generic_behavior.opposite; end

  def episode; generic_behavior.episode.slot(realm.name).squash; end
  def imbalance; "#{realm.word.ly} #{generic_behavior.imbalance}"; end


  def method_missing(meth, *arguments, &block)
    if generic_behavior.respond_to?(meth)
      generic_behavior.send(meth, *arguments, &block)
    elsif verb.respond_to?(meth)
      verb.send(meth, *arguments, &block)
    elsif noun.respond_to?(meth)
      noun.send(meth, *arguments, &block)
    else
      super
    end
  end

  def tls; [verb, realm, noun].map(&:mbti).join; end
  alias mbti :tls
  def tls2; tls.switch('E', 'I'); end
  def jungian; tls.is_tls? ? tls.to_fa : tls2.to_fa; end

  def self.find_by_mbti(tls); all.find{|b| b.mbti == tls}; end

  def eg; realm.send(underscored); end
  def switch_attitude; realm + generic_behavior.switch_attitude; end

  def switch_focus; realm + generic_behavior.switch_focus; end

end
