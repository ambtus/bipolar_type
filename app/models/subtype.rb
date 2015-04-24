class Subtype
  LETTERS = (Attitude::LETTERS.product(Realm::LETTERS)).map(&:join)

  def initialize(string)
    @index = LETTERS.index(string)
    raise "#{string} isn't a Subtype" unless @index
    @letters = string
    @attitude = Attitude.find(letters.first)
    @realm = Realm.find(letters.last)
  end
  attr_reader :letters, :attitude, :realm

  SUBTYPES = LETTERS.collect{|choice| Subtype.new(choice)}
  def self.all; SUBTYPES; end

  def self.find(letters); SUBTYPES[LETTERS.index(letters)]; end

  def next; Subtype.find(@attitude.next.letter + @realm.letter); end
  def previous; Subtype.find(@attitude.previous.letter + @realm.letter); end

  def wing?(subtypes)
    subtypes.each{|s| return true if s.attitude == self.attitude}
    subtypes.each{|s| return true if s.realm == self.realm}
    return false
  end

  def description
   [
    attitude.ed,
    realm.adjective,
    attitude.vert,
   ].map(&:capitalize).join(" ")
  end

  def description; [attitude.description, realm.description].join; end

  def mbti; [@attitude.mbti, @realm.mbti].join.mbti_order; end
  def description_with_mbti; "#{description} (#{mbti})"; end

  delegate :consume, :energy, :average, :median, :produce, :produce_we, :things, :unproduced, :unit, :full, :empty, :adjective, :shorter, to: :realm

  def number; attitude.send(realm.adjective); end
  def amount; realm.send(attitude.adjective); end
  def total; number*amount; end
  def rounded; Float("%.1g" % (total)).to_i; end # Subtype.all.map(&:rounded).uniq.size < 5

  def units; number == 1 ? @realm.unit : @realm.unit.pluralize; end
  def energy_units; number == 1 ? @realm.energy_unit : @realm.energy_unit.pluralize; end

  def averaged
    if @attitude.index < 2
      median * amount
    else
      number * average
    end
  end

  def amount_units; [amount, energy_units].join("-"); end
  def number_units; [number.word, amount_units].join(" "); end
  def short; "#{consume} #{number_units}"; end
end
