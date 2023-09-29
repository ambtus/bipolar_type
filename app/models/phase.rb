class Phase < Concept

  def initialize(string)
    @symbol = string
    @verb = Verb.send(string.first)
    @noun = Noun.send(string.second)
  end
  attr_reader :symbol, :verb, :noun

  def path; Rails.application.routes.url_helpers.behavior_path(self.symbol); end

  ########
  SYMBOLS = %w{ UE US GS GE}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def opposite; self.next.next; end

  def behaviors; Realm.all.add(self); end

  def mbti; [verb, noun].map(&:mbti).join; end
  def words; [verb.word, noun.word].to_phrase; end
  alias eg :words

  def underscored; words.gsub(' ', '_'); end

  def method_missing(meth, *arguments, &block)
    if verb.respond_to?(meth)
      verb.send(meth, *arguments, &block)
    else
      super
    end
  end

  def switch_attitude; verb.other + noun; end
  def switch_focus; verb + noun.other; end

  def severity; %w{ dangerous painful wasteful unhealthy}[index]; end
  def imbalance; index.odd? ? "fat" : "thin"; end

  def season; %w{Early\ Summer Late\ Summer Early\ Winter Late\ Winter }[index]; end
  def moon; %w{Waxing🌔Gibbous Waning🌖Gibbous Waning🌘Crescent Waxing🌒Crescent }[index]; end
  def day; %w{ Wednesday Friday Weekend Monday}[index]; end
  def time; %w{ Noonish Afternoon Evening Morning}[index]; end

  def short_when; [season, time].to_phrase; end

  def horizontal_when; [season, moon, day, time].join(" | "); end
  def vertical_when; [season, moon, day, time].join('<br>').html_safe; end

  def episode; verb.episode.slot(season.first_word); end

end
