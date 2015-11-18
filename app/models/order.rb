class Order < Indexable

  ########
  LETTERS = %w{e i}
  ALL = LETTERS.collect{|letter| self.new letter}
  LETTERS.each{|l| define_singleton_method(l) {all[LETTERS.index l]}}
  ########

  def behaviors(realm)
    if letter == "i"
      [realm.graze, realm.burst_out]
    elsif letter == "e"
      [realm.putz, realm.binge]
    else
      raise "letters are defined wrong in order.rb"
    end
  end

  def schedule(realm); Phrase.duration *behaviors(realm); end

end
