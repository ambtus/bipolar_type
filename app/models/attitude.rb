class Attitude
  LETTERS = %w{ep ej ip ij}

  def initialize(letter)
    raise "#{letter} isn't an Attitude" unless LETTERS.include?(letter)
    @index = LETTERS.index(letter)
    @path = letter
  end
  attr_reader :index, :path

  ATTITUDES = LETTERS.collect{|letter| Attitude.new(letter)}
  def self.all; ATTITUDES; end
  def self.find(letter); ATTITUDES[LETTERS.index(letter)]; end

  def +(realm); Subtype.find(realm.path + self.path); end
  def subtypes; Realm.all.add(self); end

  LETTERS.each {|r| define_singleton_method(r) {find(r)}}

  def first; path.first == "i" ? "sensitive" : "insensitive"; end
  def second; path.second == "p" ? "consumer" : "producer"; end
  def default; path.second == "p" ? "consume" : "produce"; end
  def name; [first,second].map(&:capitalize).join; end

  def in_or_out; "consuming or producing"; end

  def goal; path.second == "p" ? "lose unwanted potential energy" : "gain wanted potential energy"; end

  def change; path.second == "p" ? "consume less and produce more" : "consume more and produce less"; end

  def morning
    case path
    when "ep"
      "consume less"
    when "ej"
      "produce less"
    when "ip"
      "produce more"
    when "ij"
      "consume more"
    end
  end

  def morning_backfire
    case path
    when "ep"
      "produce less"
    when "ej"
      "consume less"
    when "ip"
      "consume more"
    when "ij"
      "produce more"
    end
  end

  def evening
    case path
    when "ep"
      "produce more"
    when "ej"
      "consume more"
    when "ip"
      "consume less"
    when "ij"
      "produce less"
    end
  end

  def evening_backfire
    case path
    when "ep"
      "consume more"
    when "ej"
      "produce more"
    when "ip"
      "produce less"
    when "ij"
      "consume less"
    end
  end

end
