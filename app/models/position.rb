class Position

  def initialize(mbti); @mbti = mbti; end
  attr_reader :mbti
  alias inspect :mbti

  MBTIS = %w{Dominant Inferior Tertiary Auxiliary } # cycle order not display/sort order
  def mbti_index; MBTIS.index @mbti; end
  def name; mbti; end

  def path;    %w{1 4 3 2}[mbti_index]; end
  def display; %w{¹ ⁴ ³ ²}[mbti_index]; end

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

  def considerations
    case mbti
    when 'Dominant'
      'These behaviors are usually healthy and satisfying. They are especially helpful when needing to remain focused on one of the other behaviors in the same quadrant that needs to be done but is more stressful. Just be careful not to allow it to slide into unhealthy behaviors in the next quadrant.'
    when 'Auxiliary'
      'These behaviors are often healthy and satisfying. You should not let a little pain or stress prevent you from doing them when they need to be done. But you should stop (for now) as soon as you perceive significant pain or stress.'
    when 'Tertiary'
      'These behaviors are sometimes healthy or satisfying. You should do them if they can be done without stress or pain, but stop if you perceive even minor discomfort; they rarely need to be done.'
    when 'Inferior'
      'These behaviors are rarely healthy or satisfying. Refrain from starting them unless you are <em>already</em> happy and stress-free and <em>pay attention</em>: do not combine them with other behaviors in the same quadrant. And move on to the next behavior in the cycle as soon as you start to experience even minor signs of stress or discomfort.'
    else
    end.html_safe
  end

end
