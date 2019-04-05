class Realm < Concept

  SYMBOLS = %w{S N F T}

  ########
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  PATHS.each do |path|
    define_singleton_method(path) {ALL[PATHS.index(path)]}
  end
  ########

  SYMBOLS.each do |symbol|
    define_singleton_method(symbol.downcase) {ALL[SYMBOLS.index(symbol)]}
  end

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude); subtypes.find{|s| s.attitude == attitude}; end

  def adjective; %w{physical mental spiritual material}[index]; end
  def adverb; adjective + "ly"; end

  def kinetic; %w{thermal electrical sound mechanical}[index]; end
  def energy; %w{calories data affect money}[index]; end
  def potential; %w{fat knowledge moral assets}[index]; end

  def self.measurements; ALL.map(&:measurement); end

  def sense; %w{smell sight hearing touch}[index]; end
  def appear; %w{smell look sound feel}[index]; end

  def change; %w{walk\ around think\ about talk\ to shop\ for}[index]; end
  def use_energy; change.first_word; end
  def location; %w{place idea person thing}[index]; end
  def thing; %w{where thing one thing}[index]; end
  def locations; location.pluralize; end
  def a_location; [location.an, location].join(" "); end
  def change_locations; [change, locations].join(" "); end
  def exhausted; %w{sore stupid inarticulate mistrusted}[index]; end
  def attempt; %w{go consider tell buy}[index]; end

  def harvest; %w{eat look\ at empathize\ with work\ with}[index]; end
  def get_energy; harvest.first_word; end
  def resource; %w{food sight voice tool}[index]; end
  def resources; resource.pluralize; end
  def a_resource; [resource.an, resource].join(" "); end
  def many_resources; [resources.many, resources].join(" "); end
  def harvest_resources; [harvest, resources].join(" "); end
  def emotional; %w{disgusted afraid miserable angry}[index]; end
  def process; %w{digest analyze listen\ to use}[index]; end

  def healthy; %w{nutritious predictive loving useful}[index]; end
  def strength; %w{muscles logic words credit}[index]; end
  def less_strength; [strength.less, strength].join(" "); end

  def splurges
    case symbol
    when "S" #go extra places
      "holidays, vacations, extra trips"
    when "T" #buy extra things
      "upgrades, luxuries, extra features"
    when "N" #consider extra ideas
      "improbabilites, fantasies, extra possibilities"
    when "F" #tell extra people
      "strangers, outsiders, extra people"
    end
  end
  def binges
    case symbol
    when "S" #eat triggery foods
      "sweets, desserts, extra carbs"
    when "T" #work with triggery tools
      "knives, guns, extra weapons"
    when "N" #look at triggery sights
      "art, pictures, extra colorful details"
    when "F" #listen to triggery voices
      "music, songs, extra intonation"
    end
  end

end
