class Hours < Avian

  ########
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each{|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def start_day; (GT + 4.hours) + self.index.hours; end

  def range(phase)
    start = start_day + phase.index.hours * 4
    end_day = start + 4.hours
    [start, end_day].map(&:short_hour).join('—')
  end

  def description
    case index
    when 0
      "(stronger sensitivity to sunlight: the day is centered around solar noon)".html_safe
    when 2
      '(equally sensitivity to sunlight and temperature)'.html_safe
    when 4
      "(stronger sensitivity to temperature: the day is centered around the warmest part which is hours later)".html_safe
    end
  end

end

