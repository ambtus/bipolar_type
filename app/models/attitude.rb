class Attitude

  def initialize(array)
    @both = array
    @first = array.first
    @second = array.second
  end
  attr_reader :first, :second

  def inspect; @both.map(&:inspect).join; end
  def path; @both.map(&:path).join; end
  def symbol; @both.map(&:symbol).join; end

  ALL = First::ALL.collect do |first|
               Second::ALL.collect do |second|
                  self.new [first,second]
                end
            end.flatten

  def self.all; ALL; end

  ALL.each{|s| define_singleton_method(s.path) {s}}
  def self.paths; ALL.map(&:path); end

  def <=>(other); [first, second] <=> [other.first, other.second]; end

  def subtypes; Subtype.all.select{|s| s.attitude == self}; end
  def +(realm); subtypes.find{|s| s.realm == realm}; end

  def description; @both.map(&:description).join(" "); end
  def name; "#{description.titleize} (#{symbol})"; end

  def locations; @both.map(&:location); end
  def loc; locations.map(&:first).join; end

  def more_or_less
    case loc
    when "tr", "bl"
      "less"
    when "tl", "br"
      "more"
    end
  end

end
