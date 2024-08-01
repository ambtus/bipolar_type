class Position

  def initialize(mbti); @mbti = mbti; end
  attr_reader :mbti
  alias inspect :mbti

  MBTIS = %w{Dominant Inferior Auxiliary Tertiary} # cycle order not display/sort order
  def mbti_index; MBTIS.index @mbti; end
  def name; mbti; end

  def path;    %w{1 4 2 3 }[mbti_index]; end
  def display; %w{¹ ⁴ ² ³}[mbti_index]; end

  ALL = MBTIS.collect {|mbti| self.new mbti}
  def next; ALL[(mbti_index+1)%4]; end
  def opposite; self.next.next; end
  def previous; opposite.next; end

  def self.all; ALL; end
  def self.each(&block);ALL.each(&block); end
  def self.dominant; ALL.first; end
  def self.inferior; ALL.second; end
  def dominant?; self.class.dominant == self; end
  def inferior?; self.class.inferior == self; end

  ALL.each_with_index do |instance, index|
    %w{mbti}.each do |thing|
      define_singleton_method(instance.send(thing)) {ALL[index]}
      define_singleton_method(instance.send(thing).downcase) {ALL[index]}
    end
  end

  def sort_order; ALL.values_at(2,0,3,1); end
  def sort_index; sort_order.index self; end
  def <=>(other); sort_index <=> other.sort_index; end



end
