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

  def adjective; %w{physical mental emotional financial}[index]; end
  def adverb; adjective + "ly"; end

  def energy; %w{calories bits emotions pennies}[index]; end
  def reserves; %w{fat knowledge motivation savings}[index]; end
  def strength; %w{muscle logic language credit}[index]; end

  def intake; %w{eat watch listen work}[index]; end
  def sense; %w{taste see hear touch}[index]; end
  def resource; %w{food truth voice tool}[index]; end
  def toxins; %w{poisons lies censures junk}[index]; end
  def signal; %w{disgust fear shame anger}[index]; end
  def intake_pain; %w{disgusted afraid suicidal angry}[index]; end
  def mild_intake_pain; %w{nauseated anxious embarassed irritated}[index]; end
  def appear; %w{taste look sound feel}[index]; end
  def appears; %w{tastes looks sounds feels}[index]; end
  def empty; %w{hungry curious bored poor}[index]; end
  def full; %w{restless informed loved rich}[index]; end

  def resources; resource.pluralize; end
  def get_energy; [sense, resources].to_phrase; end
  def get_more_energy; [sense, "more", resources].to_phrase; end
  def an_resource; [resource.an, resource].to_phrase; end

  def output; %w{walk predict talk spend}[index]; end
  def impact; %w{go imagine influence own}[index]; end
  def target; %w{place possibility person thing}[index]; end
  def output_pain; %w{sore stupid misunderstood indebted}[index]; end

  def targets; target.pluralize; end
  def a_target; [target.an, target].to_phrase; end
  def use_energy; [impact, targets].to_phrase; end
  def use_more_energy; [impact, "more", targets].to_phrase; end

  def thing; %w{where thing body thing}[index]; end
  def anything; "any#{thing}"; end
  def nothing; "no#{thing}"; end
  def something; "some#{thing}"; end
end
