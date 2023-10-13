class Behavior < Concept

  def initialize(string)
    @symbol = string
    @verb = Verb.send(string.first)
    @realm = Realm.send(string.second)
    @noun = Noun.send(string.third)
  end
  attr_reader :symbol, :verb, :realm, :noun

  def path; Rails.application.routes.url_helpers.behavior_path(self.symbol); end
  def nature_path; Rails.application.routes.url_helpers.nature_path(Nature.jump_path(self)); end

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


  def siblings; Phase.all.add(realm); end
  def cousins; Realm.all.add(phase); end

  def balancer; realm + phase.switch_attitude; end
  def displacer; realm + phase.switch_focus; end
  def opposite; realm + phase.opposite;end
  # b.opposite.balancer == b.displacer

  def my_siblings; [self, displacer, balancer, opposite]; end

  def episode; [realm.name, phase.episode].to_phrase.to_wbr.html_safe; end

  def partial_episode; [realm.name, verb.episode].to_phrase; end

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

  def imbalance; [realm.word, verb.imbalance].to_phrase.to_wbr.html_safe; end
  def imbalance_phrase; Words.imbalances[symbol.chop].join(', '); end
  def imbalance_first_word; Words.imbalances[symbol.chop].first; end
  def imbalance_eg; [imbalance, imbalance_first_word.wrap].to_phrase.html_safe; end


  def short_phrase; [Words.verb_words[symbol], Words.noun_words[realm.symbol]].to_phrase; end
  def example_lines; Words.examples[symbol]; end
  def aka; example_lines.lines.first; end
  def short_phrase_aka; [short_phrase, aka].to_phrase; end
  def example_list; example_lines.lines.join('<br />').html_safe; end

  def name_eg; [name, aka].to_phrase.html_safe; end

end
