class Order < Indexable

  ########
  LETTERS = %w{d h}
  ALL = LETTERS.collect{|letter| self.new letter}
  LETTERS.each{|l| define_singleton_method(l.next) {all[LETTERS.index l]}}
  def path; string.next; end
  ########

  def behaviors(realm)
    index.odd? ? [realm.graze, realm.burst] : [realm.putz, realm.binge]
  end

  def schedule(realm); Phrase.duration *behaviors(realm); end

end
