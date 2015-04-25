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

  delegate :number, to: :attitude

  # delegate everything else to realm
  def method_missing(sym, *args, &block)
    @realm.send sym, *args, &block
  end

  def energy_chunks; number == 1 ? energy_chunk : energy_chunk.pluralize; end
  def chunks; number == 1 ? chunk : chunk.pluralize; end

  def number_chunks; [number.word, chunks].join(" "); end
  def size; realm.send(attitude.adjective); end
  def size_chunks; [size, energy_chunks].join("-"); end

  def too_much; @attitude.index < 2 ? 3 * size : median_size * number; end
  def too_few; @attitude.index < 2 ? median_size * number : 3 * size ; end
  def just_right; (number*size).to_i; end
  # check that the numbers are all within the same ballpark
  def Subtype.check_equivalencies
    Realm.all.each do |realm|
     print realm.subtypes.map(&:just_right)
     print " "
     puts realm.median_size * 3
    end;true
  end

  # best for the subtype
  def natural_chunks; "#{number.word} #{size_chunks}".squish; end
  def act_naturally(modifier=""); "#{get} #{modifier} #{natural_chunks} a day".squish; end

  # for the discovery
  def choice
    case @attitude.index
    when 0
      "rarely #{empty}"
    when 1
      "usually too #{full}"
    when 2
      "usually too #{empty}"
    when 3
      "rarely #{full}"
   end
  end

end
