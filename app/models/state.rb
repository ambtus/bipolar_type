class State < Concept

  SYMBOL = Mood::SYMBOL.collect do |mood|
            Aspect::SYMBOL.collect do |aspect|
              mood + aspect
          end
        end.flatten

  ALL = SYMBOL.collect {|symbol| self.new symbol}
  def self.sorted; ALL.values_at(2,0,1,3); end

  def mood; Mood.find_by(symbol.first); end
  def aspect; Aspect.find_by(symbol.second); end
  def parts; [aspect, mood ]; end

  def +(thing)
    Behavior.all.find{|p| p.state == self && p.focus == thing}
  end

  def flip; mood.opposite + aspect ; end
  def flop; mood + aspect.opposite ; end
  def opposite; mood.opposite + aspect.opposite ; end

  def verb; mood.verb; end
  def noun; aspect.static; end
  def static; [verb, noun].to_phrase; end
end
