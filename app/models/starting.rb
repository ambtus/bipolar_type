class Starting < Sign

  ALL = LETTERS.collect{|letter| self.new letter}

  def why(energy)
    case string
    when "i" #negative internal signal
      "I feel #{energy.empty}"
    when "e" #postive external signal
      "the #{energy.resource_seems_good}"
    end.to_phrase
  end

end
