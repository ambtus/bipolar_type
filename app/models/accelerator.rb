class Accelerator < Transition

  ########
  LETTERS = %w{j p}
  ALL = LETTERS.collect{|letter| self.new letter}
  def <=>(other); other.index <=> index; end
  ########

end
