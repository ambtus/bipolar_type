class Stopping < Sign

  ALL = LETTERS.collect{|letter| self.new letter}

  def why(energy)
    case string
    when "i" #positive internal signal
      "I feel #{energy.full}"
    when "e" #negative external signal
      "the #{energy.resources_are_bad}"
    end.to_phrase
  end

end
