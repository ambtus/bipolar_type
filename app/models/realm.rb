class Realm

  def initialize(symbol); @symbol = symbol; end
  attr_reader :symbol
  alias path :symbol
  alias inspect :symbol

  SYMBOLS = %w{S T F N X}
  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  def self.all; ALL[0,4]; end
  def self.each(&block);ALL[0,4].each(&block); end
  def index; SYMBOLS.index @symbol; end

  def generic?; index == 4 ; end
  def self.generic; ALL.last; end
  def mbti; generic? ? '' : @symbol; end

  NAMES = %w{Physical Financial Affective Mental Generic}
  def name; NAMES[index]; end

  def symbolic_name; [symbol.colon, name].to_phrase; end

  ALL.each_with_index do |instance, index|
    %w{symbol name}.each do |thing|
      define_singleton_method(instance.send(thing)) {ALL[index]}
      define_singleton_method(instance.send(thing).downcase) {ALL[index]}
    end
  end

  def subtypes; Subtype.all.select{|s| s.realm == self}; end
  def +(behavior); subtypes.find{|s| s.behavior == behavior}; end

  def adjective; generic? ? '' : name.downcase; end
  def adverb; adjective.ly; end

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
