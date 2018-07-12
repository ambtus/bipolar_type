class Realm < Concept

  ########
  ACRONYMS = %w{s n f t}
  ALL = ACRONYMS.collect {|letter| self.new letter}
  ACRONYMS.each do |letter|
    define_singleton_method(letter) {ALL[ACRONYMS.index(letter)]}
  end
  %w{first second third fourth}.each_with_index do |ordinal, index|
    define_singleton_method(ordinal) {ALL[index]}
  end
  ########

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude); subtypes.find{|s| s.attitude == attitude}; end

  def adjective; %w{physical mental spiritual material}[index]; end
  def description; adjective; end
  def name; adjective.capitalize; end
  def adverb; adjective + "ly"; end
  def symbol; name.first; end

  def fat; %w{voluptuous knowledgeable moral rich}[index]; end
  def thin; %w{thin theoretical realistic cash-poor}[index]; end
  def weak; %w{still calm quiet unencumbered}[index]; end
  def strong; %w{strong smart eloquent wealthy}[index]; end

  def recharging; %w{eating learning listening earning}[index]; end
  def fasting; "not #{recharging}"; end
  def laboring; %w{moving thinking talking spending}[index]; end
  def resting; "not #{laboring}"; end


  def energy; %w{calories information opinions money}[index]; end
  def reserves; %w{fat knowledge conscience savings}[index]; end
  def goals; %w{actions plans relationships purchases}[index]; end
  def resources; %w{foods facts stories jobs}[index]; end


  def overwhelmed; %w{sick afraid suicidal angry}[index]; end
  def strength; %w{muscles logic vocabulary credit}[index]; end
  def fatigued; %w{sore stupid misunderstood indebted}[index]; end
end
