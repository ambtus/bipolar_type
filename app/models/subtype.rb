class Subtype

  def initialize(array)
    @triplet = array
    @first = array.first
    @realm = array.second
    @second = array.third
  end
  attr_reader :realm, :first, :second
  def attitude; Attitude.send(first.path + second.path); end

  ALL = Realm::ALL.collect do |realm|
               Attitude::ALL.collect do |attitude|
                  self.new [attitude.first,realm,attitude.second]
                end
            end.flatten

  def self.all; ALL; end


  def peers; ALL.select{|s| s.realm == realm || s.attitude == attitude} - [self]; end
  def wings; ALL.select{|s| attitude.wings.include? s.attitude}; end
  def answer_path; Answer.first.next(self); end

  def <=>(other); [attitude, realm] <=> [other.attitude, other.realm]; end

  def method_missing(meth, *arguments, &block)
    if realm.respond_to?(meth)
      realm.send(meth, *arguments, &block)
    elsif attitude.respond_to?(meth)
      attitude.send(meth, *arguments, &block)
    else
      super
    end
  end

  def inspect; @triplet.map(&:inspect).join; end
  def path; @triplet.map(&:path).join; end

  ALL.each{|s| define_singleton_method(s.path) {s}}
  def self.paths; ALL.map(&:path); end

  def description; @triplet.map(&:description).join(" "); end
  def name; description.titleize; end

end
