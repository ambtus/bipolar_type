class Order < Indexable

  ########
  LETTERS = %w{e i}
  ALL = LETTERS.collect{|letter| self.new letter}
  LETTERS.each{|l| define_singleton_method(l) {all[LETTERS.index l]}}
  ########

  def behaviors(realm)
    index.odd? ? [realm.graze, realm.burst] : [realm.putz, realm.binge]
  end

  def schedule(realm); Phrase.duration *behaviors(realm); end

end
