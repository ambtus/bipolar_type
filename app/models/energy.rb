class Energy < Concept

  ADJECTIVES = %w{physical mental financial social}
  GETS = %w{eat watch earn listen}
  USES = %w{walk choose buy talk}
  PRODUCTIONS = %w{exercise think spend communicate}
  MEASURES = %w{calories information money emotions}
  TRIGGERS = ["sweet carbohydrates", "colorful details", "cash payments", "musical intonations"]
  BUFFERS = ["fats and proteins", "black and white shapes and outlines",
             "credits or deposits", "written words"]

  ########
  ACRONYMS = ADJECTIVES.map(&:first)
  ALL = ACRONYMS.collect {|letter| self.new letter}
  ACRONYMS.each do |letter|
    define_singleton_method(letter) {ALL[ACRONYMS.index(letter)]}
  end
  ########

  def subtypes; Subtype.all.select{|s| s.energy == self}; end
  def +(state); subtypes.find{|s| s.state == state}; end

  def adjective; ADJECTIVES[index]; end
  def name; adjective.capitalize; end
  def symbol; path.upcase; end

  def get; GETS[index]; end
  def use; USES[index]; end
  def produce; PRODUCTIONS[index]; end
  def energy; MEASURES[index]; end
  def triggers; TRIGGERS[index]; end
  def buffers; BUFFERS[index]; end

  def using; use.gsub(/e$/, '') + 'ing'; end
  def getting; get + 'ing'; end

end
