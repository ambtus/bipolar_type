class Sensitivity < Indexable

  ADJECTIVE = %w{extroverted introverted}

  ########
  IDENTIFIERS = ADJECTIVE.map(&:first)
  def self.paths; IDENTIFIERS; end
  ALL = IDENTIFIERS.collect{|letter| self.new letter}
  def self.all; self::ALL; end
  all.each { |i| define_singleton_method(i.path) {all[IDENTIFIERS.index i.string]} }
  ########

  def attitudes; Attitude.all.select{|s| s.sensitivity == self}; end

  def top?; index.even?; end

  def adjective; choose Adjective, ADJECTIVE; end
  def description; adjective; end
  def name; description.capitalize; end

  def drugs; top? ? "stimulants" : "sedatives"; end

end
