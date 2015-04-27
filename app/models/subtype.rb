class Subtype
  LETTERS = Preference::LETTERS.product((Attitude::LETTERS.product(Realm::LETTERS))).map(&:join)

  def initialize(string)
    @index = LETTERS.index(string)
    raise "#{string} isn't a Subtype" unless @index
    @letters = string
    @preference = Preference.find(letters[0])
    @attitude = Attitude.find(letters[1])
    @realm = Realm.find(letters[2])
  end
  attr_reader :letters, :preference, :attitude, :realm

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

  def description; [preference.description, attitude.adjective, realm.description, attitude.noun].join; end

  def mbti; [@attitude.mbti, @realm.mbti].join.mbti_order; end
  def description_with_mbti; "#{description} (#{mbti})"; end

  delegate :get?, :get_how_many, :get_what, :use_how_many, :use_what, to: :attitude

  # delegate everything else to realm
  def method_missing(sym, *args, &block)
    @realm.send sym, *args, &block
  end

  def get_daily; get_how_many * realm.send(get_what); end
  def use_daily; use_how_many * realm.send(use_what); end
  def daily_difference; get_daily - use_daily; end
  # check that the numbers all look right
  def Subtype.check_numbers
    Realm.all.each do |realm|
     print realm.medium * 2
     print realm.subtypes.map(&:get_daily)
     print realm.subtypes.map(&:use_daily)
     print realm.subtypes.map(&:daily_difference)
     puts ""
     end;true
  end

  def get_or_use; get? ? realm.get : realm.use; end
  def get_or_use_resources; [get_or_use, generic_resources].join(" "); end

  def preference_attitude
    case @preference.index
    when 0
      "love to #{get_or_use_resources}"
    when 1
      "like to #{get_or_use_resources}"
    when 2
      "don’t mind #{get_or_use_resources.ing}"
    when 3
      "can sometimes #{get_or_use_resources}"
   end
  end

  def attitude_realm
    case @attitude.index
    when 0
      "rarely too #{empty}"
    when 1
      "usually too #{full}"
    when 2
      "usually too #{empty}"
    when 3
      "rarely too #{full}"
   end
  end

  # for the discovery
  def choice; "I #{preference_attitude} and I am #{attitude_realm}"; end

end
