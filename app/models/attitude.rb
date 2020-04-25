class Attitude < Concept

  SYMBOLS = %w{E S W N }

  ########
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  PATHS = SYMBOLS.map(&:downcase)
  PATHS.each do |path|
    define_singleton_method(path) {ALL[PATHS.index(path)]}
  end
  ########

  SYMBOLS.each do |symbol|
    define_singleton_method(symbol.downcase) {ALL[SYMBOLS.index(symbol)]}
  end

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  def +(realm); subtypes.find{|s| s.realm == realm}; end

  def position; %w{ east south west north}[index]; end
  def opposite; ALL[(index + 2).modulo(4)]; end
  def previous; ALL[(index + 3).modulo(4)]; end
  def subsequent; ALL[(index + 1).modulo(4)]; end

  def season; %w{ spring summer fall winter}[index]; end
  def time; %w{ morning day evening night}[index]; end
  def time_period; [season, time].to_phrase ; end

  def beginning; %w{ dawn solar-mid-morning solar-mid-afternoon dusk}[index]; end
  def ending; subsequent.beginning; end
  def mid; %w{ sunrise solar-noon sunset solar-midnight}[index]; end

  def behavior; %w{ work refresh play sleep\ &\ dream}[index]; end
  def energy_flow; %w{ use\ stored\ energy get\ fresh\ energy use\ fresh\ energy store\ &\ conserve\ energy}[index]; end

  def name; behavior.titleize; end

end
