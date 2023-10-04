class Phase < Concept

  def initialize(string)
    @symbol = string
    @verb = Verb.send(string.first)
    @noun = Noun.send(string.second)
  end
  attr_reader :symbol, :verb, :noun

  def path; Rails.application.routes.url_helpers.behavior_path(self.symbol); end
  def answer_path; Rails.application.routes.url_helpers.answer_path(self.symbol); end

  ########
  SYMBOLS = %w{GE UE US GS }
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def behaviors; Behavior.select{|b| b.phase == self}; end
  def +(realm); behaviors.find{|b| b.realm == realm}; end

  def both; [verb, noun]; end
  def mbti; both.map(&:mbti).join; end
  def words; both.map(&:word).to_phrase; end

  def underscored; words.gsub(' ', '_'); end

  def switch_attitude; verb.opposite + noun; end
  def switch_focus; verb + noun.opposite; end

  def natures; (strong? ? both.reverse : both).map(&:nature); end
  def natural_state; natures.join(' & ').html_safe; end

  def method_missing(meth, *arguments, &block)
    if verb.respond_to?(meth)
      verb.send(meth, *arguments, &block)
    elsif noun.respond_to?(meth)
      noun.send(meth, *arguments, &block)
    else
      super
    end
  end

  def season; %w{Winter Spring Summer Fall}[index]; end
  def month; %w{February May August November}[index]; end

  def moon; %w{Waxing🌒Crescent Waxing🌔Gibbous Waning🌖Gibbous Waning🌘Crescent}[index]; end

  def day; %w{Monday Tuesday Thursday Friday}[index]; end

  def time; %w{Morning Midday Afternoon Evening}[index]; end
  def hour; %w{8am 12noon 4pm 8pm}[index]; end

  def horizontal_when; [season, month, moon, day, time, hour].join(' | '); end
  def vertical_when; horizontal_when.gsub(' | ', '<br>').html_safe; end

  def episode; [season.first_word, verb.episode].join; end

end
