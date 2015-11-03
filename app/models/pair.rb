class Pair

  # yes, there's probably a better way, but this works
  # and it only has to run once on startup
  LETTERS = Subtype::LETTERS.multiply(Subtype::LETTERS).flatten.reject{|x| x[0] == x[3]}.reject{|x| x[1] == x[4]}.reject{|x| x[2] == x[5]}

  def initialize(letters)
    raise "#{letters} isn't a Pair" unless LETTERS.include?(letters)
    @index = LETTERS.index(letters)
    @path = letters
  end
  attr_reader :path

  PAIRS = LETTERS.collect{|letters| Pair.new(letters)}
  def self.all; PAIRS; end
  def self.find(letters); PAIRS[LETTERS.index(letters)]; end

  def potentials; Subtype.all.select{|s| other_realms.include?(s.realm) && other_sas == s.sa}.sort_by{|s| [s.realm.path, s.attitude.path]}; end

  def quads; potentials.collect{|p| Quad.find(path + p.path)}; end

  def subtypes; path.scan(/.../).collect{|p| Subtype.find(p)}; end
  def inferior; subtypes.first; end
  def tertiary; subtypes.second; end

  def name; [inferior.name, tertiary.too.capitalize].join(" and "); end

  def tertiary_nature; tertiary.nature; end

  def other_realms; Realm.all - subtypes.map(&:realm); end

  def other_sas
    case inferior.path.chars.values_at(0,2).join
    when "ip", "ej"
      "arational"
    when "ij", "ep"
      "rational"
     end
  end

end
