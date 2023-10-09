class Hours < Concept

  BT = Time.utc(2023,1,1,21,30)
  AL = 16.hours

  def initialize(string); @symbol = string; end
  attr_reader :symbol

  ########
  SYMBOLS = %w{G M N E C D }
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def self.generic; self.G; end
  def generic?; self == Hours.G; end

  def first; %w{ generic severe mild euthymic mild severe }[index]; end
  def second; %w{ \  mania mania \  depression depression }[index]; end
  def words; [first, second].to_phrase; end

  def sleep_for; [8, 6, 7, 8, 9, 10][index].hours; end
  def phase_length; (24.hours - sleep_for)/4.0; end

  def range(phase)
    if generic?
      phase.time_eg
    else
      start_of_range = BT - (4-phase.index)*phase_length
      [start_of_range, start_of_range + phase_length].map(&:short_hour).join('-')
    end
  end

  def description
    case index
    when 1
      "(try not to sleep less than 6 hours)".html_safe
    when 3
      '(sleep ~8 hours)'.html_safe
    when 5
      "(try not to sleep more than 10 hours)".html_safe
    end
  end

end

