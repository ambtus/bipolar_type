class Attitude < Concept

  ########
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  PATHS.each do |path|
    define_singleton_method(path) {ALL[PATHS.index(path)]}
  end
  %w{first second third fourth}.each_with_index do |ordinal, index|
    define_singleton_method(ordinal) {ALL[index]}
  end
  ########

  def self.for_table; ALL.values_at(0,1,3,2); end

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  def +(realm); subtypes.find{|s| s.realm == realm}; end

  def opposite; ALL[(index + 2).modulo(4)]; end

  def self.question_order; ALL.values_at(3, 1, 0, 2); end

  def season; %w{winter spring summer autumn}[index]; end
  def name; season.titleize; end
  def seasonal; season; end
  def action; %w{labor refuel sleep do}[index]; end
  def problem; %w{burn\ out explosion stagnation implosion}[index]; end
  def suffer; %w{burn\ out explode stagnate implode}[index]; end
  def suffering; suffer.ing; end

  def manic?; [0,3].include?(index); end
  def early?; index < 2 ;end
  def transitional?; index.odd?; end

  def state; manic? ? "mania" : "depression"; end
  def duration; transitional? ? "acute" : "chronic"; end
  def episode; [duration, state].join(" "); end

  def result; %w{maintain gain maintain lose}[index]; end
  def resulting; result.ing; end

  def ending
    case season
      when "summer", "winter"
        "indefinitely"
      when "spring"
        "until you explode"
      when "autumn"
        "until you implode"
    end
  end

end
