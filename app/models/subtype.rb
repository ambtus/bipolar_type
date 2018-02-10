class Subtype

  def initialize(array)
    @energy = array.first
    @state = array.second
  end
  attr_reader :energy, :state

  ALL = Energy::ALL.collect do |energy|
          State::ALL.collect do |state|
            self.new [energy,state]
          end
        end.flatten

  def self.all; ALL; end

  def method_missing(meth, *arguments, &block)
    if energy.respond_to?(meth)
      energy.send(meth, *arguments, &block)
    elsif state.respond_to?(meth)
      state.send(meth, *arguments, &block)
    else
      super
    end
  end

  def <=>(other); state.index <=> other.state.index; end

  def path; [@energy.path, @state.path].join; end
  def inspect; path; end
  def symbol; path.upcase; end

  ALL.each{|s| define_singleton_method(s.path) {s}}
  def self.paths; ALL.map(&:path); end

  def siblings; state.subtypes + energy.subtypes - [self]; end

  def name; "#{@energy.name} #{@state.name}"; end

  def overreaction; state.overreaction(energy); end

end
