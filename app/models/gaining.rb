class Gaining < Sign

  def when_full(energy); Phrase.new [timing, energy.full]; end

  def sensitivity(energy); Phrase.new [nature, "ignore unpleasant", energy.sensory_signals]; end

end
