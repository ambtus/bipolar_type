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

  #delegate :get, :energy, :etc, to: :realm
  # delegate is cleaner but too hard to maintain at the moment
  def method_missing(sym, *args, &block)
    @realm.send sym, *args, &block
  end
  def chunks; number == 1 ? chunk : chunk.pluralize; end
  def energy_chunks; number == 1 ? energy_chunk : energy_chunk.pluralize; end

  def number; attitude.send(realm.adjective); end
  def number_chunks; [number.word, chunks].join(" "); end
  def size; realm.send(attitude.adjective); end
  def size_chunks; [size, energy_chunks].join("-"); end

  def too_much; @attitude.index < 2 ? median_chunks * size : median_size * number; end
  def too_few; @attitude.index < 2 ? median_size * number : median_chunks * size ; end

  def just_right; number*size; end
  # if the numbers are all more or less equivalent then the following is true
  # Subtype.all.map(&:rounded).uniq.size < 5
  def rounded; Float("%.1g" % (just_right)).to_i; end

  # best for the subtype
  def act_best; "#{get} #{number.word} #{size_chunks}"; end

  # for the discovery
  def choice
    case @attitude.index
    when 0
      "usually #{full} enough"
    when 1
      "too #{full}"
    when 2
      "too #{empty}"
    when 3
      "usually #{empty} enough"
   end
  end

end
