class Losing < Sign

  def when_empty(energy); Phrase.new [timing, energy.empty]; end

  def size_of; choose Adjective, %w{large small}; end
  def size(energy); Phrase.new ["relatively", size_of, energy.storage_containers]; end

end
