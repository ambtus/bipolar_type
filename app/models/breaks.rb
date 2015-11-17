class Breaks < Transition

  ########
  ALL = LETTERS.collect{|letter| self.new letter}
  ########

  def why(realm)
    case signal_location
    when "external"
      Phrase.new ["the", realm.resource, "is", realm.compelling]
    when "internal"
      Phrase.new ["I", "feel", realm.empty]
    end
  end

  def am(realm)
    case signal_location
    when "external"
      realm.fat
    when "internal"
      realm.thin
    end
  end

end
