class Behavior

  def initialize(symbol); @symbol = symbol; end
  attr_reader :symbol
  alias path :symbol
  alias inspect :symbol
  alias display :symbol

  SYMBOLS = %w{GE BE US RS}
  def index; SYMBOLS.index @symbol; end
  def <=>(other); index <=> other.index; end
  def manic?; [1,2].include? index; end
  def type; symbol.first; end

  NAMES = %w{Get<wbr>Energy Burn<wbr>Energy Use<wbr>Strength Recover<wbr>Strength Generic<wbr>Behavior}
  def name; NAMES[index].html_safe; end
  def symbolic_name; [@symbol.colon, name].to_safe_phrase; end
  def names; name.split('<wbr>'); end
  def phrase; names.to_phrase.downcase; end
  def send_name; names.join.underscore; end

  ACTIONS = %w{Feed Flee Fight Rest Action}
  def action; ACTIONS[index]; end
  def send_action; action.downcase; end

  def send_examples; send_action + '_examples'; end

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

  def compulsions; Subtype.all.select{|s| s.behavior == self && s.priority.last? && !s.realm.generic?}; end

end
