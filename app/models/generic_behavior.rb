class GenericBehavior < Concept

  def initialize(string)
    @symbol = string
    @verb = Verb.send(string.first)
    @noun = Noun.send(string.second)
  end
  attr_reader :symbol, :verb, :noun

  ########
  SYMBOLS = %w{GE UE US GS}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def opposite; self.next.next; end

  def behaviors; Realm.all.add(self); end

  def problem; verb.problem == "Mania" ? season : time; end
  def problems; [problem, verb.problem]; end
  def problem_names; problems.join.squash; end

  def mbti; [verb, noun].map(&:mbti).join; end

  def words; [verb.word, noun.word].to_phrase; end
  alias eg :words
  def underscored; words.gsub(' ', '_'); end

  def switch_attitude; verb.other + noun; end
  def switch_focus; verb + noun.other; end

  def at; index == 1 ? "at " : "in the "; end
  def time; %w{Dawn Morning Afternoon Dusk}[index]; end
  def day; %w{Monday Wednesday Friday Weekend}[index]; end
  def moon; %w{Waxing🌒Crescent Waxing🌔Gibbous Waning🌖Gibbous Waning🌘Crescent}[index]; end
  def season; %w{Late\ Winter Spring Fall Early\ Winter}[index]; end

  def at_time; [at, time.downcase].to_phrase; end

  def short_description; [day, time, "in", season].to_phrase; end

  def inline_description; [season, moon, day, time].join(" | "); end

  def description; inline_description.gsub(" | ", '<br>').html_safe; end

end
