class Realm < Concept

  SYMBOLS = %w{P M F S}
  ########
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  PATHS.each do |path|
    define_singleton_method(path) {ALL[PATHS.index(path)]}
  end
  %w{first second third fourth}.each_with_index do |ordinal, index|
    define_singleton_method(ordinal) {ALL[index]}
  end
  ########

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(attitude); subtypes.find{|s| s.attitude == attitude}; end

  def adjective; %w{physical mental financial social}[index]; end
  def name; adjective.titleize; end

  def energy; %w{calories facts money love}[index]; end
  def reserves; %w{fat knowledge savings self-esteem}[index]; end
  def empty; %w{hungry curious envious lonely}[index]; end
  def refuel; %w{eat watch work listen}[index]; end

  def appear; %w{taste look feel sound}[index]; end
  def sense; %w{taste see collect hear}[index]; end
  def get; %w{eat look\ for do listen\ to}[index]; end
  def process; %w{digest believe count understand}[index]; end
  def resources; %w{foods truths jobs opinions}[index]; end
  def basic; %w{savory black\ and\ white salaried sharp}[index]; end
  def necessities; %w{protein outlines credit criticism}[index]; end
  def tempting; %w{sweet colorful contracted harmonious }[index]; end
  def extras; %w{carbohydrates details cash praise}[index]; end

  def drain; %w{move think spend talk}[index]; end
  def power; %w{body brain purse voice }[index]; end
  def strength; %w{muscles rules credit conscience}[index]; end

  def achieve; %w{take put\ together make influence}[index]; end
  def part; %w{step piece payment person}[index]; end
  def goal; %w{trip puzzle purchase group}[index]; end
  def easy; %w{short simple cheap small}[index]; end
  def hard; %w{long complex expensive large}[index]; end
end
