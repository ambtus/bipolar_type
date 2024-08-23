class Priority

  def initialize(ordinal); @ordinal = ordinal; end
  attr_reader :ordinal
  alias inspect :ordinal
  alias name :ordinal
  def type; ordinal.downcase; end

  ATTITUDES = %w{First Second Third Compulsively}
  def index; ATTITUDES.index @ordinal; end
  def <=>(other); index <=> other.index; end

  def display; %w{¹ ² ³ ⁰}[index]; end
  def path; (index+1).to_s; end
  def st; (index+1).ordinalize; end

  ALL = ATTITUDES.collect {|ordinal| self.new ordinal}
  def self.all; ALL; end
  def self.each(&block);ALL.each(&block); end
  def self.last; ALL.last; end
  def last?; ALL.last == self; end

  ALL.each do |instance|
    define_singleton_method(instance.ordinal) {instance}
    define_singleton_method(instance.ordinal.downcase) {instance}
  end

  def eg; %w{replace balance subvert compulsively}[index]; end
  def symbolic_name; [path.colon, eg.capitalize].to_safe_phrase; end

  def flip; ALL[([2,3,0,1][index])]; end # flip a coin: E to I balance
  def flop; ALL[([3,2,1,0][index])]; end # flop sideways: P to J replacement
  def opposite; flip.flop; end


  def considerations
    case eg
    when 'replace'
      'These activities should be your first priority. They can replace activities which are unbalancing because they do not trigger compulsions. You will stop once you have done enough. But you must get into the habit of starting.'
    when 'balance'
      'These activities should be your second priority. They balance your compulsive behaviors activities. They need to be enabled to make them easier, but not forced, because they should be replaced by subversion activities once you are balanced.'
    when 'subvert'
      'These activites should be your third priority. They balance and support your replacement activities. They should not be started, however, until after you have finished your balancing activities.'
    when 'compulsive'
      'You will always do these activities if they need to be done. But once you start, you will find it difficult to stop before you have <em>over</em>done them. So substitute replacement activities as soon as you can.'.html_safe
    end
  end

end
