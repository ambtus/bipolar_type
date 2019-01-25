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

  def resource; %w{food answer reaction income}[index]; end
  def resources; resource.pluralize; end
  def baduns; %w{poison lies bigotry junk}[index]; end
  def energy; %w{calories information love money}[index]; end
  def give; %w{feed show give pay}[index]; end
  def gave; %w{fed showed gave paid}[index]; end
  def notice; %w{smell see hear touch}[index]; end
  def use; %w{eat look\ at listen\ to collect}[index]; end
  def use_wo; use.split.first; end
  def refuel; [use, resources].join(" "); end
  def process; %w{digest believe agree\ with sell}[index]; end
  def process_wo; process.split.first; end
  def processable; process_wo.gsub(/e?$/, '') + "able"; end
  def appear; %w{taste look sound feel}[index]; end
  def neuro; %w{serotonin norepinephrine oxytocin dopamine}[index]; end
  def triggers; %w{carbs facts compliments wages}[index]; end
  def nulls; %w{proteins suppositions criticisms investment\ incomes}[index]; end
  def empty; %w{hungry curious lonely overdrawn}[index]; end
  def parts; [triggers, nulls, buffers].to_sentence; end
  def bad; %w{sick afraid suicidal angry}[index]; end
  def organ; %w{mouth eyes ears hands}[index]; end
  def reject; %w{vomit forget cry fight}[index]; end
  def reserves; %w{fat memories confidence savings}[index]; end
  def cause; %w{starvation stupidity suicide exposure}[index]; end

  def act; %w{walk think talk buy}[index]; end
  def behave; %w{move analyze speak spend}[index]; end
  def behaved; %w{moved analyzed spoke spent}[index]; end
  def accomplish; %w{go question convince build}[index]; end
  def accomplished; %w{went questioned convinced built}[index]; end
  def goal; %w{place idea person thing}[index]; end
  def goals; goal.pluralize; end
  def what; %w{where what who what}[index]; end
  def anything; %w{anywhere anything anyone anything}[index]; end
  def something; %w{somewhere something someone something}[index]; end
  def them_there; index > 0 ? "them" : "there"; end
  def easy; %w{level simple allied cheap}[index]; end
  def hard; %w{high complex hostile expensive}[index]; end
  def labor; [accomplish, hard, goals].join(" "); end
  def relax; [accomplish, easy, goals].join(" "); end
  def strength; %w{muscle intelligence eloquence credit}[index]; end

end
