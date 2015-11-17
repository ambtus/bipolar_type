class Accelerator < Transition

  ########
  LETTERS = %w{p j}
  ALL = LETTERS.collect{|letter| self.new letter}
  ########

  def why(realm)
    case signal_location
    when "external"
      Phrase.new ["the", realm.resource, "was", realm.filling]
    when "internal"
      Phrase.new ["I", "feel", realm.full]
    end
  end

  def am(realm)
    case signal_location
    when "external"
      realm.energetic
    when "internal"
      realm.strong
    end
  end

end
