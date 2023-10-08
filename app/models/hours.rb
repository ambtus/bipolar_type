class Hours < Concept

  def initialize(string); @symbol = string; end
  attr_reader :symbol

  ########
  SYMBOLS = %w{E B A N O}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each{|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def self.average; self.A; end

  def first; %w{early night average early night}[index]; end
  def second; %w{bird bird avian owl owl}[index]; end
  def words; [first, second].to_phrase; end

  def start_of_day; (GT + 4.hours) + self.index.hours; end

  def range(phase)
    start_of_range = start_of_day + phase.index.hours * 4
    end_of_range = start_of_range + 4.hours
    [start_of_range, end_of_range].map(&:short_hour).join('-')
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

