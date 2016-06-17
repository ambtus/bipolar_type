class Quad < Phrase

  def self.my_path; "snft"; end
  def self.first; Quad.send my_path; end

  def initialize(string)
    @path = string
    if Attitude.paths.include? (string.first)
      @attitudes = string.scan(/./).collect{|a| Attitude.send(a)}
      @attitudes.check_constraints Attitude, 4, 4
      @realms = Realm.all
      super(@realms)
    else
      @realms = string.scan(/./).collect{|a| Realm.send(a)}
      @realms.check_constraints Realm, 4, 4
      @attitudes = Attitude.all
      super(@realms)
    end
  end
  attr_reader :realms, :path, :attitudes

  def subtypes; @realms.add(@attitudes); end

  def self.paths; Realm.all.permutation(4).map(&:join); end
  ALL = self.paths.collect{|path| self.new(path)}
  def self.all; ALL; end
  ALL.each {|quad| define_singleton_method(quad.path) {quad} }
  def self.in_order; ALL.sort_by{|q| [q.realms.second, q.realms.third]}; end

  def differentiated?; realms.uniq.size == 4 && attitudes.uniq.size == 4; end

  %w{first second third fourth}.each  do |meth|
    define_method(meth) {subtypes.send(meth)}
  end


  def names; subtypes.map(&:mbti); end
  def inspect; names.join("•"); end
  def name; inspect; end


  def ep; Mbti.new("e#{realms.values_at(0,1).sort.map(&:path).join}p"); end
  def ip; Mbti.new("i#{realms.values_at(0,2).sort.map(&:path).join}p"); end
def ej;  Mbti.new("e#{realms.values_at(1,3).sort.map(&:path).join}j"); end
def ij; Mbti.new("i#{realms.values_at(2,3).sort.map(&:path).join}j"); end

end
