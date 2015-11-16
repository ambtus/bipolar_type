class Quad < Phrase

  def self.first_path; "eSeeTiiNeiFi"; end
  def self.first; Quad.new first_path; end

  def initialize(string)
    @subtypes = string.scan(/.../).collect{|s| Subtype.find(s)}.sort
    @subtypes.check_constraints Subtype, 4, 4
    super(@subtypes)
  end
  attr_reader :subtypes

  def inspect; subtypes.join("•").to_word; end
  def name; inspect; end

end
