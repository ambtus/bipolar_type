class Answer < Concept

  def initialize(string)
    @symbol = string
    @realm = Realm.send(string.first)
    @question = Behavior.questions[string.second.alpha_index]
    @phase = Phase.all[string.third.to_i]
  end
  attr_reader :symbol, :realm, :question, :phase

  def question_set; @symbol.chars.values_at(0,1).join; end
  def answer_set; @symbol.chars.values_at(0,2).join; end

  def possibles; @realm.behaviors.collect{|b| b.send(question)}; end

  def behavior; @realm + @phase; end

end
