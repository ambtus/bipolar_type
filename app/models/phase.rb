class Phase < Concept

  SYMBOL = Mood::SYMBOL.collect do |mood|
            Should::SYMBOL.collect do |should|
              mood + should
          end
        end.flatten

  ALL = SYMBOL.collect {|symbol| self.new symbol}.values_at(0,2,1,3)

  def index; [0,2,1,3][super]; end

  def mood; Mood.find_by(symbol.first); end
  def should; Should.find_by(symbol.second); end
  def parts; [mood, should]; end

  def extreme?; mood.index == should.index; end

end
