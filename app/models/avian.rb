class Avian < Concept

  def initialize(string); @symbol = string; end
  attr_reader :symbol

  def path; Rails.application.routes.url_helpers.realm_path(self.symbol); end
  def answer_path; Rails.application.routes.url_helpers.answer_path(self.symbol); end

  ########
  SYMBOLS = %w{A B N Y Z}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each{|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def self.derive_from(realms)
    string = realms.map(&:symbol).join
    if string.without("PA") == "MF"
      string.first == "M" ? self.A : self.B
    elsif string.without("PA") == "FM"
      string.first == "F" ? self.Z : self.Y
    else
      self.N
    end
  end

  def first; %w{early night not early night}[index]; end
  def second; %w{bird bird avian owl owl}[index]; end
  def words; [first, second].to_phrase; end

  def start_day; (GT + 4.hours) + self.index.hours; end
  def hours(phase)
    start = start_day + phase.index.hours * 4
    end_day = start + 4.hours
    [start, end_day].map(&:short_hour).join('—')
  end

  def start_month; GT + (self.index * 8.days); end
  def months(phase)
    start = start_month + phase.index.months * 3
    end_month = start + 3.months
    [start, end_month].map(&:short_month).join('—')
  end

  def description
    case index
    when 0
      '(stronger sensitivity to sunlight: centered around <a class="external" href="https://en.wikipedia.org/wiki/Noon#Solar_noon">solar noon</a> and the summer solstice)'.html_safe
    when 2
    when 4
      '(stronger sensitivity to temperature: centered around <a class="external" href="https://www.globe.gov/explore-science/scientists-blog/archived-posts/sciblog/index.html_p=95.html">four hours after solar noon</a> and a month after the summer solstice)'.html_safe
    end
  end
end
