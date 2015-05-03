class Subtype
    LETTERS = ["tpe", "spe", "tep", "sep", "tej", "sej","tje", "sje",
               "npe", "fpe", "nep", "fep", "nej", "fej","nje", "fje",
               "tpi", "spi", "tip", "sip", "tij", "sij", "tji", "sji",
               "npi", "fpi", "nip", "fip", "nij", "fij", "nji", "fji",]

  def initialize(string)
    raise "#{string} isn't a Subtype" unless LETTERS.include?(string)
    @index = LETTERS.index(string)
    @letters = string
    @realm_letter = string[0]
    @attitude_letter = string[1]
    @bias_letter = string[2]
    @trait_letters = string[0,2]
    @state_letters = string[1,2].mbti_order
  end
  attr_reader :letters

  SUBTYPES = LETTERS.collect{|choice| Subtype.new(choice)}
  def self.all; SUBTYPES; end

  def self.find(letters); SUBTYPES[LETTERS.index(letters)]; end

  def realm; Realm.find(@realm_letter); end
  def attitude; Attitude.find(@attitude_letter); end
  def bias; Attitude.find(@bias_letter); end
  def trait; Trait.find(@trait_letters); end
  def state; State.find(@state_letters); end

  def mbti; (trait.mbti.upcase + @bias_letter).mbti_order; end

  def clockwise?; attitude.next == bias; end

  def previous_trait; clockwise? ? trait.previous : trait.next; end
  def next_trait; clockwise? ? trait.next : trait.previous ; end

  def previous_aka; previous_trait.aka; end
  def next_aka; next_trait.aka; end

  def short; [previous_trait, trait, next_trait].map(&:aka).to_sentence; end
  def with_mbti; "(#{mbti})"; end
  def short_with_mbti; [short, with_mbti].join(" "); end

  private
  def method_missing(sym, *args, &block)
    trait.send sym, *args, &block
  end
end
