class Priority
 def initialize(string)
    @letters = string
    @trait_letters = string[0,8]
    @direction = string[8] == "n" ? "next" : "previous"
    @state_letters = string[9,2]
  end

  def traits; @trait_letters[0,8].scan(/../).collect{|ra| Trait.find(ra)}; end
  def trait_direction; @direction + "_subtype" ; end
  def subtypes; traits.map(&trait_direction.to_sym); end
  def state; State.find(@state_letters); end
  def next_state; state.send(@direction); end
  def previous_state; @direction == "next" ? state.send("previous") : state.send("next"); end


  def dominant; subtypes.select{|s| s.state == state}.first;end
  def auxiliary;  subtypes.select{|s| s.state == next_state}.first;end
  def inferior; subtypes.select{|s| s.state == previous_state}.first; end
  def tertiary; (subtypes - [dominant, auxiliary, inferior]).first; end
  def sorted_subtypes; [dominant, auxiliary, tertiary, inferior]; end

  def adjectively; dominant.realm.short + "ly"; end
  def depressed; dominant.depressed; end
  def manic; dominant.manic; end
  def energies; dominant.energies; end

  def mbti; [state, dominant.realm, auxiliary.realm].map(&:mbti).join.mbti_order; end


end
