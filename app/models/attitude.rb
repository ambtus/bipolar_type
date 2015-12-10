class Attitude < Indexable

  LETTERS = %w{EP EJ IP IJ}
  ALL = LETTERS.collect{|letter| self.new letter}
  all.each { |r| define_singleton_method(r.path) {all[LETTERS.index r.string]} }

  def ordinal; %w{first second third fourth}[index]; end

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end

  def adjective; choose Adjective, %w{obese thin fat anorexic}; end
  def manic_affect; choose Adjective, %w{wonderful bad good horrible}; end
  def depressed_affect; choose Adjective, %w{horrible good bad wonderful }; end

  def amount; choose Word, %w{less less more more}; end
  def sensitivity; Phrase.new [amount, "sensitive"]; end
  def feeling; choose Word, %w{full full overfull overfull}; end

  def direction; choose Word, %w{stop stop start start}; end
  def first_action; choose Verb, %w{produce consume consume produce}; end
  def first_lesson; Phrase.new [direction, first_action.ing]; end

  def name; Phrase.new [first_lesson.titleize, parenthesize]; end

  def second_action; choose Verb, %w{ consume produce produce consume }; end
  def second_lesson; Phrase.new [direction, second_action.ing]; end

  def how_many_potentials(potentials)
    array = case index
    when 0
      [potentials.many, "more", potentials]
    when 1
      [potentials.fewer, potentials]
    when 2
      [ "more", potentials]
    when 3
      ["far", potentials.fewer, potentials]
    end
    Phrase.new array
  end

end
