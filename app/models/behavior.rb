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
  def unbalanced; phase.unbalanced.prefix(realm.word.ly); end
  def displaced; phase.displaced.prefix(realm.word.ly); end

  def siblings; Phase.all.add(realm); end
  def cousins; Realm.all.add(phase); end

  def previous; realm + phase.previous; end
  def next; realm + phase.next; end
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

  def aka; Words.short_phrase[symbol]; end
  def name_eg; [name, aka.wrap].to_phrase.html_safe; end

  def phrase; [Words.verb_words[symbol], Words.noun_words[realm.symbol]].to_phrase; end
  def phrase_aka; [phrase, aka.wrap].to_phrase; end

  def example_list; Words.examples[symbol].lines.join('<br />'); end

end
