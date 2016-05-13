class Quad < Phrase

  def self.my_path; Realm.all.add(Attitude.all).map(&:path).join; end
  def self.first; Quad.send my_path; end

  def initialize(string)
    @path = string
    @subtypes = string.scan(/../).collect{|a| Subtype.send(a)}
    @subtypes.check_constraints Subtype, 4, 4
    super(@subtypes)
  end
  attr_reader :path, :subtypes

  def inspect; subtypes.join("•"); end
  def name; subtypes.map(&:letters).join("•"); end

end
