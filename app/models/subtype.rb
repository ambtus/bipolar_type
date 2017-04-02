class Subtype

  def initialize(array)
    @pair = array
    @realm = array.first
    @attitude = array.second
  end
  attr_reader :realm, :attitude

  ALL = Realm::ALL.collect do |realm|
               Attitude::ALL.collect do |attitude|
                  self.new [realm,attitude]
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

  def inspect; @pair.map(&:inspect).join; end
  def path; @pair.map(&:path).join; end
  def symbol; ([0,3].include? attitude.index) ? path.reverse.upcase : path.upcase; end

  ALL.each{|s| define_singleton_method(s.path) {s}}
  def self.paths; ALL.map(&:path); end

  def description; [attitude.description.split.first, realm.description, attitude.description.split.second].join(" "); end
  def name; description.titleize; end

end
