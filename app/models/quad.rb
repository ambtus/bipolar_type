class Quad < Phrase

  def self.first_path; "nstf"; end
  def self.first; Quad.new first_path; end

  def initialize(string)
    @realms = string.scan(/./).collect{|s| Realm.send(s)}
    @realms.check_constraints Realm, 4, 4
    super(@realms)
  end
  attr_reader :realms
  def subtypes; realms.add(Attitude.all); end

  def inspect; subtypes.join("•").to_word; end
  def name; inspect; end

end
