class Realm < Concept

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

  def reserves; %w{fat knowledge savings ego}[index]; end

  def refuel; %w{eat watch earn listen}[index]; end

  def get; %w{eat look\ for use listen\ to}[index]; end
  def resource; %w{food information tools voices}[index]; end

  def sense; %w{taste see feel hear}[index]; end
  def basic; %w{savory black\ and\ white rough sharp}[index]; end
  def necessities; %w{protein outlines functionality criticism}[index]; end
  def tempting; %w{sweet colorful smooth soothing}[index]; end
  def extras; %w{carbohydrates details features praise}[index]; end

  def power; %w{muscles logic credit values}[index]; end
  def work; %w{move think spend talk}[index]; end

  def make; %w{do solve make influence}[index]; end
  def part; %w{task piece payment person}[index]; end
  def whole; %w{project puzzle purchase audience}[index]; end
end
