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

  def consumption_preference
    case path
    when "ep", "ip"
      "energy"
    when "ej", "ij"
      "strength"
    end
  end

  def out_of_something
    case path
    when "ep", "ij"
      "out of strength"
    when "ej", "ip"
      "out of energy"
    end
  end

  def result
    case path
    when "ep"
      "too much energy"
    when "ej"
      "too much strength"
    when "ij"
      "too little energy"
    when "ip"
      "too little strength"
    end
  end

  def name; result.split.map(&:capitalize).join; end

  def stress
    case path
    when "ep"
      "input less"
    when "ej"
      "output less"
    when "ip"
      "output more"
    when "ij"
      "input more"
    end
  end
  def relax
  case path
    when "ep"
      "output more"
    when "ej"
      "input more"
    when "ip"
      "input less"
    when "ij"
      "output less"
    end
  end
  def more_you_relax; [relax.split.last, "you", relax.split.first].join(" "); end
  def more_you_can_play
  case path
    when "ep"
      "more you will be able to input"
    when "ej"
      "more you will be able to output"
    when "ip"
      "less you will have to output"
    when "ij"
      "less you will have to input"
    end
  end
  def play; [more_you_can_play.split.last, more_you_can_play.split.first].join(" "); end
  def make_the_best_of_it
  case path
    when "ep", "ij"
      "stop consuming energy and just consume strength"
    when "ej"
      "provide for yourself"
    when "ip"
      "take care of yourself"
    end
  end
  def short_mtboi
    make_the_best_of_it.split(" and ").first
  end

  def method_missing(method, *args, &block)
    if Realm.generic.respond_to? method
      Realm.generic.send(method, *args, &block)
   else
     super
   end
  end

end
