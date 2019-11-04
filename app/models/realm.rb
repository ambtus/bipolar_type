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

  def rights; ALL.select{|x| x.index > self.index}; end

  def adjective; %w{physical mental social financial}[index]; end

  def energy; %w{calories data love money}[index]; end
  def reserves; %w{fat knowledge self-esteem savings}[index]; end
  def strength; %w{muscle rules vocabulary credit}[index]; end

  def intake; %w{eat watch listen take}[index]; end
  def sense; %w{taste see hear touch}[index]; end
  def resource; %w{food event voice tool}[index]; end
  def resources; resource.pluralize; end
  def get_energy; [sense, resources].to_phrase; end
  def intake_pain; %w{disgusted afraid ashamed angry}[index]; end
  def mild_intake_pain; %w{nauseated anxious embarassed irritated}[index]; end
#   def appear; %w{taste look sound feel}[index]; end
  def empty; %w{hungry curious lonely needy}[index]; end
  def process; %w{digest analyze empathize collect}[index]; end

  def output; %w{walk think talk give}[index]; end
  def impact; %w{go create tell own}[index]; end
  def target; %w{place synthesis person thing}[index]; end
  def targets; target.pluralize; end
  def a_target; [target.an, target].to_phrase; end
  def use_energy; [impact, targets].to_phrase; end
  def output_pain; %w{sore stupid inarticulate indebted}[index]; end

  def thing; %w{where thing body thing}[index]; end
  def anything; "any#{thing}"; end
  def nothing; "no#{thing}"; end
  def something; "some#{thing}"; end
  def doing_anything; [impact.ing, anything].to_phrase; end
  def do_something; [impact, something].to_phrase; end
end
