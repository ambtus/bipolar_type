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
  def targets; target.pluralize; end
  def a_target; [target.an, target].to_phrase; end
  def thing; %w{body where thing thing}[index]; end
  def which; %w{who where what what}[index]; end

  def adjective; %w{social physical financial mental}[index]; end
  def adverb; adjective + "ly"; end

  def energy; %w{affect calories money information}[index]; end

  def output; %w{talk walk buy think}[index]; end
  def oprep; %w{to around \  about}[index]; end
  def output2; %w{write farm pay plan}[index]; end
  def oprep2; %w{about \  for for}[index]; end
  def use_energy; [output, oprep, "or", output2, oprep2, targets].to_phrase; end
  def use_more_energy; [output, "more", "or", output2, oprep2, "more", targets].to_phrase; end
  def using_energy; [output.ing, oprep, "or", output2.ing, oprep2, targets].to_phrase; end
  def use_them; [output, oprep, "or", output2, oprep2, "them"].to_phrase; end

  def self.outputs; ALL.map(&:output); end

  def intake; %w{listen eat work watch}[index]; end
  def iprep; %w{to \  with \  }[index]; end
  def intake2; %w{read drink compete learn}[index]; end
  def iprep2; %w{about in for from }[index]; end
  def get_energy; [intake, iprep, "or", intake2, iprep2, targets].to_phrase; end
  def get_more_energy; [intake, "more", "or", intake2, iprep2, "more", targets].to_phrase; end
  def getting_energy; [intake.ing, iprep, "or", intake2.ing, iprep2, targets].to_phrase; end
  def get_them; [intake, iprep, "or", intake2, iprep2, "them"].to_phrase; end

  def self.intakes; ALL.map(&:intake); end

  def reserves; %w{self-esteem fat savings memories}[index]; end
  def many_reserves; [reserves.many, reserves].to_phrase; end
  def few_reserves; [reserves.few, reserves].to_phrase; end

  def appear; %w{sound smell feel look}[index]; end
  def pain; %w{shame disgust anger fear}[index]; end

  def painful;%w{shaming disgusting infuriating terrifying}[index]; end
  def pained;%w{ashamed disgusted angry afraid}[index]; end

end
