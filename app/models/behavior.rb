class Behavior

  def initialize(mbti); @mbti = mbti; end
  attr_reader :mbti
  alias path :mbti
  alias inspect :mbti
  alias display :mbti

  MBTIS = %w{IP EP EJ IJ} # cycle order (IP first) not display/sort order (EP first)
  def cycle_index; MBTIS.index @mbti; end

  ALL = MBTIS.collect {|mbti| self.new mbti}
  def next; ALL[(cycle_index+1)%4]; end
  def opposite; ALL[(cycle_index+2)%4]; end
  def previous; ALL[(cycle_index+3)%4]; end

  def self.all; ALL; end
  def self.each(&block);ALL.each(&block); end

  NAMES = %w{Get<wbr>Energy Burn<wbr>Energy Use<wbr>Strength Recover<wbr>Strength Generic<wbr>Behavior}
  def name; NAMES[cycle_index]; end
  def symbolic_name; [@mbti.colon, name].to_safe_phrase; end

  def names; name.split('<wbr>'); end
  def clear_name; names.join; end
  def send_name; clear_name.underscore; end

  def first_name; names.first; end
  ALL.each_with_index do |instance, index|
    %w{mbti first_name}.each do |thing|
      define_singleton_method(instance.send(thing)) {ALL[index]}
      define_singleton_method(instance.send(thing).downcase) {ALL[index]}
    end
  end

  def self.sort_order; ALL.values_at(1,2,0,3); end
  def sort_order; self.class.sort_order ; end
  def sort_index; sort_order.index self; end
  def <=>(other); sort_index <=> other.sort_index; end

end
