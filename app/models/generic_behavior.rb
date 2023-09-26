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

  def behaviors; Realm.all.add(self); end

  def opposite; self.next.next; end

  def problems; [noun.problem, verb.problem]; end
  def problem_names; problems.map(&:name).join; end

  def mbti; [verb, noun].map(&:mbti).join; end

  def words; [verb.word, noun.word].to_phrase; end

  def unwanted; "stuck doing #{name} behaviors"; end

  def description
    case symbol
    when "GE"
      "Baby<br>Spring<br>Waxing Moon<br>Monday<br>Morning".html_safe
    when "UE"
      "Child<br>Summer<br>Full Moon<br>Midweek<br>Day".html_safe
    when "US"
      "Adolescent<br>Autumn<br>Waning Moon<br>Friday<br>Afternoon".html_safe
    when "GS"
      "Adult<br>Winter<br>New Moon<br>Weekend<br>Night".html_safe
    end
  end
  def inline_description; description.gsub('<br>', " | "); end

  def at; index == 1 ? "at " : "in the "; end
  def time; description.split('<br>').last; end
  def season; description.split('<br>').second; end

  def day; description.split('<br>').fourth; end

  def short_description; [day, time, "in", season].to_phrase; end


end
