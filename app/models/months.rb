class Months < Avian

  ########
  SYMBOLS = %w{E B A N O} + %w{E B A N O}.map(&:downcase)
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each{|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def below?; @symbol == @symbol.downcase; end
  def index; (SYMBOLS.index @symbol)%5; end
  def under; ALL[index + 5]; end

  def name; below? ? super.invert_case.html_safe : super; end

  def start_month; GT + (self.index * 8.days); end

  def range(phase)
    phase = below? ? phase.opposite : phase
    start = start_month + phase.index.months * 3
    end_month = start + 3.months
    [start, end_month].map(&:short_month).join('—')
  end

  def description
    case index
    when 0
      "(stronger sensitivity to sunlight: winter is centered around the shortest day)".html_safe
    when 2
      '(equally sensitivity to sunlight and temperature)'.html_safe
    when 4
      "(stronger sensitivity to temperature: winter is centered around the coldest day which may be a month later)".html_safe
    end
  end

end
