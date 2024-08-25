class Type

  def initialize(string)
    @path = string
    @quadrants = string.split('•').collect{|s| Quadrant.send(s)}
  end
  attr_reader :path, :quadrants

  def problems; @quadrants.add(Realm.all); end
  def inspect; problems.map(&:display).join('•'); end
  alias name :inspect

  class << self
    def my_path; 'IP•EJ•EP•IJ'; end
    def my_type; Type.new(my_path); end
  end

end

