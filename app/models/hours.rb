class Hours < Concept

  BT = Time.utc(2023,1,1,21,30)
  AL = 16.hours

  def initialize(string); @symbol = string; end
  attr_reader :symbol

  ########
  SYMBOLS = %w{G M N O P E A B C D }
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  SYMBOLS.each {|s| define_singleton_method(s) {ALL[SYMBOLS.index(s)]}}
  ########

  def self.generic; self.G; end
  def generic?; self == Hours.G; end

  def first; %w{ generic severe moderate mild high euthymic low mild moderate severe }[index]; end
  def second; %w{ \   mania mania mania \  \  \  depression depression depression }[index]; end
  def words; [first, second].to_phrase; end

  def sleep_for; [8, 6, 6.5, 7, 7.5, 8, 8.5, 9, 9.5, 10][index].hours; end
  def phase_length; (24.hours - sleep_for)/4.0; end

  def start_of_range(phase); BT - (4-phase.index)*phase_length; end
  def end_of_range(phase); start_of_range(phase) + phase_length; end

  def start_time(phase); generic? ? phase.time_eg : start_of_range(phase).short_hour; end
  def end_time(phase); generic? ? nil : end_of_range(phase).short_hour; end

  def range(phase); [start_time(phase), end_time(phase)].compact.join('-'); end

  def description
    sleep_for.inspect
  end

end

