class Attitude
  LETTERS = %w{ip ij ep ej }

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

  MESSAGES =
    [
      "stop going",
      "stop filling up",
      "start filling up",
      "start going",
    ]

  def nature; MESSAGES[@index]; end
  def name; nature.s.split.map(&:capitalize).join; end

  def nurture; MESSAGES.values_at(2,3,0,1)[@index]; end
  def role; "#{nurture} whenever anyone or anything wants you to #{nurture}"; end

  def result; %w{full empty full empty }[@index]; end
  def i_am; "I am too #{result}"; end
  def goal; %w{empty full empty full }[@index]; end

  def should; MESSAGES.values_at(3,2,1,0)[@index]; end
  def i_should; "I should #{should}"; end

  def advice; MESSAGES.values_at(1,0,3,2)[@index]; end
end
