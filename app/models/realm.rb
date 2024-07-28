class Realm

  def initialize(symbol); @symbol = symbol; end
  attr_reader :symbol
  alias path :symbol

  NAMES = %w{Physical Financial Affective Mental Generic}
  SYMBOLS = NAMES.map(&:first)

  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  def self.all; ALL[0,4]; end
  def self.each(&block);ALL[0,4].each(&block); end
  def index; SYMBOLS.index @symbol; end
  def mbti; %w{S T F N X}[index]; end
  ALL.each_with_index do |instance, index|
    %w{symbol}.each do |thing|
      define_singleton_method(instance.send(thing)) {ALL[index]}
      define_singleton_method(instance.send(thing).downcase) {ALL[index]}
    end
  end
  %w{first second third fourth}.each do |ordinal|
    define_singleton_method(ordinal) {ALL.send(ordinal)}
  end

  def name; NAMES[index]; end
  alias inspect :name
  def symbolic_name; [symbol.colon, name].to_safe_phrase; end


  def subtypes; generic? ? Behavior.all : Subtype.all.select{|s| s.realm == self}; end
  def +(behavior); subtypes.find{|s| s.behavior == behavior}; end

  def adjective; generic? ? '' : name.downcase; end
  def adverb; adjective.ly; end

  def generic?; index == 4 ; end
  def self.generic; ALL.last; end
  def symbol; generic? ? '' : @symbol; end

  def energy; %w{calories money emotions information energy}[index]; end
  def strengths; %w{muscles credit vocabulary theories strength}[index]; end

  def gather; %w{eat earn listen\ to look\ at get}[index]; end
  def energizers; %w{carbs wages intonation details energy}[index]; end
  def get_energy; [gather, energizers].to_phrase; end
  def strengtheners; %w{protein a\ salary words results strength}[index]; end
  def recover_strength; generic? ? 'recover strength' : [gather, strengtheners].to_phrase; end

  def burn_energy; %w{run pay\ cash cry decide burn\ energy}[index]; end
  def use_strength; %w{clean use\ credit verbalize theorize use\ strength}[index]; end
  def use; %w{move buy explain predict do\ something}[index]; end
end
