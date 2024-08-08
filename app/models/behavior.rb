class Behavior

  def initialize(mbti); @mbti = mbti; end
  attr_reader :mbti
  alias path :mbti
  alias inspect :mbti
  alias display :mbti

  MBTIS = %w{IP EP EJ IJ} # cycle order (IP first) not display/sort order (EP first)
  def index; MBTIS.index @mbti; end
  def rational?; index.even?; end

  ALL = MBTIS.collect {|mbti| self.new mbti}
  def last?; ALL.last == self; end
  def st; (index + 1).ordinalize; end

  def flip; Behavior.send(%w{EP IP IJ EJ}[index]); end
  def flop; Behavior.send(%w{IJ EJ EP IP}[index]); end
  def opposite; Behavior.send(%w{EJ IJ IP EP}[index]); end


  def self.all; ALL; end
  def self.each(&block);ALL.each(&block); end

  NAMES = %w{Get<wbr>Energy Burn<wbr>Energy Use<wbr>Strength Recover<wbr>Strength Generic<wbr>Behavior}
  def name; NAMES[index].html_safe; end
  def symbolic_name; [@mbti.colon, name].to_safe_phrase; end

  def names; name.split('<wbr>'); end
  def send_name; names.join.underscore; end

  def verb; names.first; end
  def noun; names.second; end

  ALL.each_with_index do |instance, index|
    %w{mbti verb}.each do |thing|
      define_singleton_method(instance.send(thing)) {ALL[index]}
      define_singleton_method(instance.send(thing).downcase) {ALL[index]}
    end
  end

  def self.sort_order; ALL.values_at(1,2,0,3); end
  def sort_order; self.class.sort_order ; end
  def sort_index; sort_order.index self; end
  def <=>(other); sort_index <=> other.sort_index; end

end
