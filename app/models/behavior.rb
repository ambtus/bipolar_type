class Behavior < Concept

  SYMBOL = Mood::SYMBOL.collect do |mood|
             Focus::SYMBOL.collect do |focus|
               Aspect::SYMBOL.collect do |aspect|
                mood + focus + aspect
              end
            end
          end.flatten

  ALL = SYMBOL.collect{|symbol| self.new symbol}

  class << self
    def my_dominant; find_by('IFP'); end
  end

  def mood; Mood.find_by(symbol.first); end
  def focus; Focus.find_by(symbol.second); end
  def aspect; Aspect.find_by(symbol.third); end

  def parts; [mood, focus, aspect]; end

  def state; State.find_by(symbol.delete(focus.symbol)); end

  def pair; [focus,state]; end
  def self.sorted
    Focus.all.collect do |f|
      State.all.collect do |s|
        f + s
      end
    end.flatten
  end

  def flip; focus + state.flip; end
  def flop; focus + state.flop; end
  def opposite; focus + state.opposite; end

end
