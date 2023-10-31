class Phase < Concept

  def initialize(string)
    @symbol = string
    @verb = Verb.send(string.first)
    @noun = Noun.send(string.second)
  end
  attr_reader :symbol, :verb, :noun

  def path; Rails.application.routes.url_helpers.behavior_path(self.symbol); end

  ########
  SYMBOLS = %w{GE UE US GS }
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def behaviors; Behavior.select{|b| b.phase == self}; end
  def +(realm); behaviors.find{|b| b.realm == realm}; end

  def both; [verb, noun]; end
  def words; both.map(&:word).to_phrase; end

  def length; index.even? ? 'Chronic' : 'Acute'; end
  def episode; [length, verb.episode].to_wbr.html_safe; end

  def description; Words.descriptions[symbol]; end

  def reason; Words.reasons[symbol]; end
  def problem; ["too #{verb.nature}", reason].join(': ').html_safe; end

  def solution; Words.solutions[symbol]; end

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

  def start_season; Words.start_seasons[symbol]; end
  def short_when; [start_season, time].to_wbr.html_safe; end


  def season; Words.seasons[symbol]; end
  def month; '~' + Words.months[symbol]; end
  def month_range; Words.month_ranges[symbol]; end
  def season_eg; [season, month.wrap].to_phrase; end

  def moon; Words.moons[symbol]; end
  def moon_symbol; Words.moon_symbols[symbol]; end
  def day; Words.days[symbol]; end

  def time; Words.times[symbol]; end
  def hour; '~' + Words.hours[symbol]; end
  def hour_range; Words.hour_ranges[symbol]; end
  def time_eg; [hour_range, hour.wrap].to_phrase; end


  def horizontal_when; [month_range, moon_symbol, day, hour_range].join(' | '); end
  def vertical_when; horizontal_when.gsub(' | ', '<br>').html_safe; end

end
