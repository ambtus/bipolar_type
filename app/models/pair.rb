class Pair

  LETTERS = Realm::LETTERS[1,4].multiply(Subtype::LETTERS).flatten.reject{|l| l.first == l.second}

  def initialize(letters)
    raise "#{letters} isn't a Pair" unless LETTERS.include?(letters)
    @index = LETTERS.index(letters)
    @path = letters
  end
  attr_reader :path

  PAIRS = LETTERS.collect{|letters| Pair.new(letters)}
  def self.all; PAIRS; end
  def self.find(letters); PAIRS[LETTERS.index(letters)]; end

  def realm; Realm.find(path.first); end
  def subtype; Subtype.find(path[1,2]); end

  def p?; subtype.p? ; end

  def first_result; subtype.result ; end
  def goal; subtype.goal; end
  def second_result; p? ? realm.empty : realm.full ; end
  def realm_goal; p? ? realm.full : realm.empty; end
  def goals; [realm_goal, goal]; end
  def results; [first_result, second_result]; end
  def name; results.map(&:capitalize).join(" and "); end

  def episode; p? ? realm.generic + " mania" : subtype.generic + " depression"; end
  def drugged; p? ? "sedated" : "given stimulants"; end
  def drugged_result; p? ? first_result : second_result; end
  def episode_result; p? ? second_result : first_result; end
  def realm_putting; p? ? realm.output.ing : realm.input.ing ; end
  def realm_other_putting; p? ? realm.input.ing : realm.output.ing ; end
  def recovery; p? ? subtype.generic + " depression" : realm.generic +  " hypomania"; end


  def advice; "stop #{realm_putting} and start #{subtype.putting}"; end


  def other_realms; Realm.all - [realm, subtype.realm]; end
  def other_realm_paths; other_realms.map(&:path).join; end
  def other_attitude_path; p? ? "j" : "p"; end 
  def alt1; Pair.find(other_realm_paths + other_attitude_path); end 
def alt2; Pair.find(other_realm_paths.reverse + other_attitude_path); end 
  def alts; [alt1, alt2]; end

  def reversed; Pair.find(path[0,2].reverse + other_attitude_path); end

  def subtypes; [subtype, reversed.subtype]; end

end