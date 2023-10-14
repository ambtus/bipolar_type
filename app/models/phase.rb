class Phase < Concept

  def initialize(string)
    @symbol = string
    @verb = Verb.send(string.first)
    @noun = Noun.send(string.second)
  end
  attr_reader :symbol, :verb, :noun

  def path; Rails.application.routes.url_helpers.behavior_path(self.symbol); end
  def nature_path; Rails.application.routes.url_helpers.nature_path(self.symbol); end

  ########
  SYMBOLS = %w{GE UE US GS }
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def behaviors; Behavior.select{|b| b.phase == self}; end
  def +(realm); behaviors.find{|b| b.realm == realm}; end

  def both; [verb, noun]; end
  def words; both.map(&:word).to_phrase; end

  def unbalanced; verb.nature; end
  def displaced; noun.nature; end
  def natures; (index > 1 ? both.reverse : both).map(&:nature); end
  def natural_state; natures.join(' & ').html_safe; end
  def episode; both.reverse.map(&:episode).to_phrase.to_wbr.html_safe; end

  def switch_attitude; verb.opposite + noun; end
  def switch_focus; verb + noun.opposite; end

  def method_missing(meth, *arguments, &block)
    if verb.respond_to?(meth)
      verb.send(meth, *arguments, &block)
    elsif noun.respond_to?(meth)
      noun.send(meth, *arguments, &block)
    else
      super
    end
  end

  def season; Words.seasons[symbol]; end
  def month; '~' + Words.months[symbol]; end
  def season_eg; [season, month.wrap].to_phrase; end

  def moon; Words.moons[symbol]; end
  def day; Words.days[symbol]; end

  def time; Words.times[symbol]; end
  def hour; '~' + Words.hours[symbol]; end
  def time_eg; [time, hour.wrap].to_phrase; end

  def horizontal_when; [season_eg, moon, day, time_eg].join(' | '); end
  def vertical_when; horizontal_when.gsub(' | ', '<br>').html_safe; end

end
