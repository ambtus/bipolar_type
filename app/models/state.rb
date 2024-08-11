class State

  def initialize(reaction); @reaction = reaction; end
  attr_reader :reaction
  alias inspect :reaction

  REACTIONS = %w{Control Serenity Guilt Compulsion} # cycle order not display/sort order
  def index; REACTIONS.index @reaction; end
  def name; reaction; end
  def state_type; reaction.downcase; end
  def <=>(other); index <=> other.index; end

  def path;    %w{1 2 3 4}[index]; end
  def display; %w{¹ ² ³ ⁴}[index]; end

  ALL = REACTIONS.collect {|reaction| self.new reaction}
  def self.all; ALL; end
  def self.each(&block);ALL.each(&block); end
  def last?; ALL.last == self; end

  def flip; ALL[([1,0,3,2][index])]; end
  def flop; ALL[([3,2,1,0][index])]; end
  def opposite; ALL[([2,3,0,1][index])]; end

  ALL.each_with_index do |instance, index|
    %w{reaction}.each do |thing|
      define_singleton_method(instance.send(thing)) {ALL[index]}
      define_singleton_method(instance.send(thing).downcase) {ALL[index]}
    end
  end

  def considerations
    case reaction
    when 'Control'
      'These activities are always safe to start, as you will stop once you are satisfied (the need to do it is no longer urgent or critical). The more serene activities you do, the longer you will be able to continue before you need to stop.'
    when 'Guilt'
      'These activites only need to be done if you did overbalance previously or if you want to be able to overbalance later. The more compulsive activies you avoid, the less guilty you will feel for not doing enough of these activities.'
    when 'Serenity'
      'These activities are always safe to stop, as you will start again once you are ready (the need to do it becomes urgent or critical). The more controlled activities you do, the sooner you will feel ready to react to less urgent or critical situations.'
    when 'Compulsion'
      'Don’t even start! You won’t be able to stop and will overbalance and feel guilty later when you don’t want to have to rebalance.'
    else
    end
  end

end
