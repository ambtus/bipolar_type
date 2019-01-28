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

  def season; %w{spring summer autumn winter }[index]; end
  def seasonal; season; end
  def action; %w{sowing labor reaping rest}[index]; end
  def behavior; [seasonal, action].join(" "); end

  def diurnal; %w{morning day evening night }[index]; end

  def abundant?; [1,2].include?(index); end
  def early?; index < 2 ;end
  def transitional?; index.even?; end

  def state; early? ? "mania" : "depression"; end
  def duration; transitional? ? "acute" : "chronic"; end
  def episode; [duration, state].join(" "); end

  def result; %w{lose maintain gain maintain }[index]; end
  def resulting; result.ing; end

  def ending
    case season
      when "summer", "winter"
        "indefinitely"
      when "spring"
        "until you implode"
      when "autumn"
        "until you explode"
    end
  end

  def suffering
    case season
      when "winter"
        "stagnating"
      when "summer"
        "burning out"
      when "spring"
        "imploding"
      when "autumn"
        "exploding"
    end
  end

  def problem
    case season
      when "winter"
        "stagnation"
      when "summer"
        "burn out"
      when "spring"
        "implosion"
      when "autumn"
        "explosion"
    end
  end

  def name; problem.titleize; end

end
