class Nature < Indexable

  ########
  IDENTIFIERS = %w{ e i }
  def self.paths; IDENTIFIERS; end
  ALL = IDENTIFIERS.collect{|letter| self.new letter}
  def self.all; self::ALL; end
  all.each { |i| define_singleton_method(i.path) {all[IDENTIFIERS.index i.string]} }
  ########

  def attitudes; Attitude.all.select{|s| s.nature == self}; end

  def top?; index.even?; end

  def description; choose Adjective, %w{insensitive sensitive}; end
  def name; description.capitalize; end

  def drugs; top? ? "stimulants" : "sedatives"; end

end
