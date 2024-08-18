class Behavior

  def initialize(symbol); @symbol = symbol; end
  attr_reader :symbol
  alias path :symbol
  alias inspect :symbol
  alias display :symbol

  SYMBOLS = %w{Q1 Q2 Q3 Q4}
  def index; SYMBOLS.index @symbol; end

  NAMES = %w{Get<wbr>Energy Burn<wbr>Energy Use<wbr>Strength Recover<wbr>Strength Generic<wbr>Behavior}
  def name; NAMES[index].html_safe; end
  def symbolic_name; [@symbol.colon, name].to_safe_phrase; end
  def names; name.split('<wbr>'); end
  def send_name; names.join.underscore; end
  def phrase; names.to_phrase.downcase; end

  ACTIONS = %w{Feed Flee Fight Rest Action}
  def action; ACTIONS[index]; end
  def send_action; action.downcase; end

  ALL = SYMBOLS.collect {|symbol| self.new symbol}
  def last?; ALL.last == self; end
  def st; (index + 1).ordinalize; end

  def mbti; %w{IP EP EJ IJ}[index]; end
  def flip; Behavior.send(%w{EP IP IJ EJ}[index]); end
  def flop; Behavior.send(%w{IJ EJ EP IP}[index]); end
  def opposite; Behavior.send(%w{EJ IJ IP EP}[index]); end

  def self.all; ALL; end
  def self.each(&block);ALL.each(&block); end

  def verb; names.first; end
  def noun; names.second; end

  ALL.each_with_index do |instance, index|
    %w{mbti symbol verb action}.each do |thing|
      define_singleton_method(instance.send(thing)) {ALL[index]}
      define_singleton_method(instance.send(thing).downcase) {ALL[index]}
    end
  end

  def self.sort_order; ALL.values_at(1,2,0,3); end
  def sort_order; self.class.sort_order ; end
  def sort_index; sort_order.index self; end
  def <=>(other); sort_index <=> other.sort_index; end

end
