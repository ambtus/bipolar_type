class Type

  def initialize(quad, dominant)
    @quad = quad
    @dominant = dominant
  end
  attr_reader :quad, :dominant

  ALL = Quad::ALL.collect do |quad|
            quad.behaviors.collect do |dominant|
              Type.new(quad, dominant)
          end
        end.flatten.sort_by(&:dominant)

  class << self
    def my_type; ALL.find{|t| t.quad==Quad.my_quad && t.dominant==Behavior.my_dominant}; end
    def find(string); ALL.find{|t| t.quad.path == string[0,4] && t.dominant.focus.symbol == string.last}; end
  end

  def behaviors; quad.behaviors; end
  def index; behaviors.index(dominant); end
  def wings; behaviors.without(dominant).select{|b| b.aspect == dominant.aspect || b.mood == dominant.mood}; end
  def euthymic; behaviors.without(dominant).without(wings).first; end
  def symbol; [wings.first, dominant, wings.second].map(&:symbol).join('•'); end
  alias inspect :symbol

  def path; quad.path + dominant.focus.symbol; end


end
