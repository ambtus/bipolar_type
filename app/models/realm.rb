class Realm < Concept

  SYMBOLS = %w{P M A F}

  ########
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  PATHS.each do |path|
    define_singleton_method(path) {ALL[PATHS.index(path)]}
  end
  ########

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude); subtypes.find{|s| s.attitude == attitude}; end

  def adjective; %w{physical mental affective financial}[index]; end

  def resource; %w{food answer story tool}[index]; end
  def resources; resource.pluralize; end
  def baduns; %w{poisons lies bigotry junk}[index]; end
  def energy; %w{calories data affect currency}[index]; end
  def give; %w{feed show give hand}[index]; end
  def notice; %w{smell see hear touch}[index]; end
  def use; %w{eat look\ at listen\ to pick\ up}[index]; end
  def use_wo; use.split.first; end
  def refuel; [use, resources].join(" "); end
  def process; %w{digest believe agree\ with use}[index]; end
  def process_wo; process.split.first; end
  def processable; process_wo.gsub(/e?$/, '') + "able"; end
  def appear; %w{taste look sound feel}[index]; end
  def neuro; %w{serotonin norepinephrine oxytocin dopamine}[index]; end
  def energizer; %w{carb fact compliment weapon}[index]; end
  def strengthener; %w{protein supposition criticism defense}[index]; end
  def buffers; %w{fat symmetry laughter handles}[index]; end
  def empty; %w{hungry curious lonely overdrawn}[index]; end
  def parts; [energizer.s, strengthener.s, buffers].to_sentence; end
  def reserves; %w{fat knowledge self-esteem savings}[index]; end
  def sick; %w{nauseated afraid unhappy angry}[index]; end
  def organ; %w{mouth eyes ears hands}[index]; end

  def act; %w{walk think talk pay}[index]; end
  def accomplish; %w{go organize befriend buy}[index]; end
  def goal; %w{place idea person thing}[index]; end
  def goals; goal.pluralize; end
  def anything; %w{anywhere anything anyone anything}[index]; end
  def something; %w{somewhere something someone something}[index]; end
  def them_there; index > 0 ? "them" : "there"; end
  def easy; %w{level simple allied cheap}[index]; end
  def hard; %w{high complex unfamiliar expensive}[index]; end
  def labor; [accomplish, hard, goals].join(" "); end
  def relax; [accomplish, easy, goals].join(" "); end
  def strength; %w{muscle intelligence vocabulary credit}[index]; end

end
