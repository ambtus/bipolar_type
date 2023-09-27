class GenericBehavior < Concept

  def initialize(string)
    @symbol = string
    @verb = Verb.send(string.first)
    @noun = Noun.send(string.second)
  end
  attr_reader :symbol, :verb, :noun

  ########
  SYMBOLS = %w{UE GE US GS}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def opposite; self.next.next; end

  def behaviors; Realm.all.add(self); end

  def problems; [season, verb.problem.name]; end
  def problem_names; problems.join; end

  def mbti; [verb, noun].map(&:mbti).join; end

  def words; [verb.word, noun.word].to_phrase; end

  def at; index == 0 ? "at " : "in the "; end
  def time; %w{Morning Day Afternoon Night}[index]; end
  def day; %w{Monday Wednesday Friday Weekend}[index]; end
  def moon; %w{Waxing Full Waning New}[index]; end
  def season; %w{Spring Summer Fall Winter}[index]; end

  def short_description; [day, time, "in", season].to_phrase; end

  def inline_description; [season, moon + " Moon", day, time].join(" | "); end

  def description; inline_description.gsub(" | ", '<br>').html_safe; end

end
