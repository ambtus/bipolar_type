class Behavior < Concept

  def initialize(string)
    @symbol = string
    @verb = Verb.send(string.first)
    @realm = Realm.send(string.second)
    @noun = Noun.send(string.third)
  end
  attr_reader :symbol, :verb, :realm, :noun

  def path; Rails.application.routes.url_helpers.behavior_path(self.symbol); end
  def examples_path; "behaviors/#{symbol}"; end
  def imbalance_path; "behaviors/#{@realm.symbol + @verb.imbalance_symbol}"; end
  def answer_path; Rails.application.routes.url_helpers.answer_path(Answer.jump_path(self)); end

  ########
  ALL = Phase::SYMBOLS.collect do |phrase|
          Realm::SYMBOLS.collect do |realm|
            self.new [phrase.first, realm, phrase.second].join
          end
        end.flatten
  SYMBOLS = ALL.map(&:symbol)
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def words; [verb.word, realm.word, noun.word].to_phrase; end

  def phase; @verb + @noun; end

  def <=>(other); self.phase <=> other.phase; end

  def natural_state; phase.natural_state.prefix(realm.word.ly); end
  def unbalanced; phase.nature.prefix(realm.word.ly); end
  def imbalance; [phase.size, realm.word, verb.imbalance].to_phrase; end


  def siblings; Phase.all.add(realm); end
  def cousins; Realm.all.add(phase); end

  def balancer; realm + phase.switch_attitude; end
  def displacer; realm + phase.switch_focus; end
  def opposite; realm + phase.opposite;end
  # b.opposite.balancer == b.displacer

  def my_siblings; [self, displacer, balancer, opposite]; end
  def my_natures; %w{nature displacer balancer opposite}; end
  def nature(s); my_natures[my_siblings.index(s)]; end

  def episode; [noun.nature, realm.name, verb.episode].to_phrase.to_wbr.html_safe; end
  def assets; [realm.word, phase.assets].to_phrase; end

  def method_missing(meth, *arguments, &block)
    if phase.respond_to?(meth)
      phase.send(meth, *arguments, &block)
    elsif verb.respond_to?(meth)
      verb.send(meth, *arguments, &block)
    elsif noun.respond_to?(meth)
      noun.send(meth, *arguments, &block)
    else
      super
    end
  end

end
