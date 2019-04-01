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

  def energy; %w{glucose information values assets}[index]; end
  def measurement; %w{calories bits affect cost}[index]; end
  def energetic; %w{caloric informative emotional productive}[index]; end
  def less_energetic; [energetic.less, energetic].join(" "); end

  def sense; %w{smell sight hearing touch}[index]; end
  def appear; %w{smell look sound feel}[index]; end

  def change; %w{walk\ around think\ about talk\ to pay\ for}[index]; end
  def use_energy; change.first_word; end
  def location; %w{place idea person thing}[index]; end
  def thing; %w{where thing one thing}[index]; end
  def locations; location.pluralize; end
  def a_location; [location.an, location].join(" "); end
  def change_locations; [change, locations].join(" "); end
  def exhausted; %w{sore stupid inarticulate mistrusted}[index]; end
  def attempt; %w{visit consider tell buy}[index]; end

  def harvest; %w{eat look\ at listen\ to work\ with}[index]; end
  def get_energy; harvest.first_word; end
  def resource; %w{food datum opinion tool}[index]; end
  def resources; resource.pluralize; end
  def a_resource; [resource.an, resource].join(" "); end
  def many_resources; [resources.many, resources].join(" "); end
  def harvest_resources; [harvest, resources].join(" "); end
  def emotional; %w{disgusted afraid miserable angry}[index]; end
  def process; %w{digest believe love sell}[index]; end

  def healthy; %w{nutritious predictive loving useful}[index]; end
  def strength; %w{muscles logic words credit}[index]; end
  def less_strength; [strength.less, strength].join(" "); end

end
