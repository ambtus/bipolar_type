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

  def opposite_path; LETTERS.reverse[@index]; end
  def opposite; Attitude.find(opposite_path); end

  def name; %w{Collect Provide Reject Use}[@index]; end
  def result; %w{full empty full empty}[@index]; end
  def i_am; "I am too #{result}"; end

  def should
    case path
    when "ep"
      "fill up less"
    when "ej"
      "go less"
    when "ip"
      "go more"
    when "ij"
      "fill up more"
    end
  end
  def i_should; "I should #{should}"; end

  def short_role
    case path
    when "ej"
      "stop filling up"
    when "ep"
      "stop going"
    when "ip"
      "keep filling up"
    when "ij"
      "keep going"
    end
  end

  def role
    "#{short_role} whenever anyone or anything wants you to #{short_role}"
  end



  def advice
    case path
    when "ep"
      "keep going"
    when "ej"
      "keep filling up"
    when "ip"
      "stop filling up"
    when "ij"
      "stop going"
    end
  end

end
