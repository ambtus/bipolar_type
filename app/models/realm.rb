class Realm < Concept

  SYMBOLS = %w{F S T N}

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


  def target; %w{person place thing event}[index]; end
  def adjective; %w{spiritual physical material mental}[index]; end
  def energy; %w{affect calories money data}[index]; end
  def energetic; %w{social caloric financial informational}[index]; end
  def reserves; %w{self-esteem fat savings knowledge}[index]; end
  def neurochemical; %w{oxytocin serotonin dopamine glutamate?}[index]; end

  def thing; %w{one where thing thing}[index]; end
  def what; %w{who where what what}[index]; end
  def that; %w{whom where that that}[index]; end

  def targets; target.pluralize; end
  def a_target; [target.an, target].to_phrase; end
  def adverb; adjective + "ly"; end
  def an_energetic; [energetic.an, energetic].to_phrase; end
  def much_energy; [energy.much, energy].to_phrase; end
  def little_energy; [energy.little, energy].to_phrase; end
  def many_reserves; [reserves.many, reserves].to_phrase; end
  def few_reserves; [reserves.few, reserves].to_phrase; end

  def full; %w{emotional restless rich sure}[index]; end

  def output; %w{talk walk buy predict}[index]; end
  def oprep; %w{about \  \  \  }[index]; end
  def output_with_object; [output, oprep].to_phrase; end
  def use_energy; [output, oprep, targets].to_phrase; end

  def empty; %w{lonely hungry envious curious}[index]; end

  def intake; %w{listen eat earn learn}[index]; end
  def iprep; %w{to in \  about }[index]; end
  def intake_with_object; [intake, iprep].to_phrase; end
  def get_energy; [intake, iprep, targets].to_phrase; end

  def appear; %w{sound smell feel look}[index]; end

  def pain; %w{shame disgust anger fear}[index]; end
  def pained; %w{suicidal nauseated angry afraid}[index]; end
  def painful; %w{hateful disgusting infuriating frightening}[index]; end

end
