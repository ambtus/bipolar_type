class Sensitivity < Indexable

  ########
  LETTERS = %w{d h}
  ALL = LETTERS.collect{|letter| self.new letter}
  LETTERS.each{|l| define_singleton_method(l.next) {all[LETTERS.index l]}}
  def path; string.next; end
  ########

  def priority(array); index.odd? ? array : array.reverse; end

  def frequency; index.odd? ? "sometimes" : "usually"; end
end
