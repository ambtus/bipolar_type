class Priority

  def initialize(ordinal); @ordinal = ordinal; end
  attr_reader :ordinal
  alias inspect :ordinal
  alias name :ordinal
  def type; ordinal.downcase; end

  ATTITUDES = %w{First Second Third Fourth}
  def index; ATTITUDES.index @ordinal; end
  def <=>(other); index <=> other.index; end

  def display; %w{¹ ² ³ ⁴}[index]; end
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

  def flip; ALL[([1,0,3,2][index])]; end
  def flop; ALL[([3,2,1,0][index])]; end
  def opposite; ALL[([2,3,0,1][index])]; end

  def eg; %w{replace subvert balance avoid}[index]; end

  def considerations
    case ordinal
    when 'First'
      'These activities should be your first priority. They can replace activities which are unbalancing because they do not trigger compulsions. You will stop once you have done enough. But you must get into the habit of starting.'
    when 'Second'
      'These activities should be your second priority. They balance and encourage replacement activities. But they are not necessary in and of themselves if you would rather not start.'
    when 'Third'
      'These activites must be done in moderation. They are necessary for balance if you have been compulsive. But they may trigger compulsive behaviors if overdone.'
    when 'Fourth'
      'These activities should be avoided when possible. Once you start, you will find it difficult to stop. It is almost always easier to avoid starting in the first place and substitute replacement activities instead.'
    end
  end

end
