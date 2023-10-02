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

  def self.day_order; ALL.values_at(3,0,1,2); end

  def behaviors; Realm.all.add(self); end
  def +(realm); behaviors.find{|b| b.realm == realm}; end

  def mbti; [verb, noun].map(&:mbti).join; end
  def words; [verb.word, noun.word].to_phrase; end
  alias eg :words

  def underscored; words.gsub(' ', '_'); end

  def method_missing(meth, *arguments, &block)
    if verb.respond_to?(meth)
      verb.send(meth, *arguments, &block)
    elsif noun.respond_to?(meth)
      noun.send(meth, *arguments, &block)
    else
      super
    end
  end

  def switch_attitude; verb.opposite + noun; end
  def switch_focus; verb + noun.opposite; end

  def problem_order; strong? ? [noun, verb] : [verb, noun]; end
  def problems; problem_order.map(&:problem);end
  def lessers; problem_order.map(&:opposite).map(&:problem); end
  def severity; %w{ dangerous painful wasteful unhealthy }[index]; end
  def unbalance; %w{ drain overtax atrophy overfill }[index]; end
  def fix; %w{ fill repair exercise drain}[index]; end

  def destroying; %w{ tanking straining drowning exploding }[index]; end

  def self.find_solution(unbalanced)
    case unbalanced
    when "drained"
      self.GE
    when "overfilled"
      self.UE
    when "strained"
      self.GS
    when "wasted"
      self.US
    end
  end

  def season; %w{ Early\ Summer Late\ Summer Early\ Winter Late\ Winter }[index]; end
  def moon; %w{ Waxing🌔Gibbous Waning🌖Gibbous Waning🌘Crescent Waxing🌒Crescent }[index]; end
  def day; %w{ Wednesday Friday Weekend Monday }[index]; end
  def time; %w{ Forenoon Afternoon Evening Morning }[index]; end

  def when_words(which="more"); "every #{time.downcase} (#{which} often during the #{season.downcase})"; end

  def horizontal_when; [season, moon, day, time].join(" | "); end
  def vertical_when; [season, moon, day, time].join('<br>').html_safe; end

  def episode; [season.first_word, verb.episode].join; end

end
