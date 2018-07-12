class Attitude < Concept

  ########
  ACRONYMS = %w{uf of uw ow}
  ALL = ACRONYMS.collect {|letter| self.new letter}
  ACRONYMS.each do |letter|
    define_singleton_method(letter) {ALL[ACRONYMS.index(letter)]}
  end
  %w{first second third fourth}.each_with_index do |ordinal, index|
    define_singleton_method(ordinal) {ALL[index]}
  end
  ########

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  def +(realm); subtypes.find{|s| s.realm == realm}; end

  def u_or_o; path.first == "u" ? "under" : "over"; end
  def c_or_p; path.second == "f" ? "fuel" : "work"; end
  def description; [u_or_o, c_or_p].join(" "); end

  def noun; %w{productive responsible content active}[index]; end
  def episode; index < 2 ? "mania" : "depression"; end
  def description; [noun, episode].join(" "); end
  def name; noun.titleize; end

  def result; %w{thin fat weak strong}[index]; end
  def goal; %w{fat thin strong weak}[index]; end
  def good_behavior; %w{recharging fasting laboring resting}[index]; end
  def problem; %w{manic depressed depressed manic}[index]; end
end
