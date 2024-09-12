class Answer

  def self.first_path; 'Q1'; end
  def self.first; Answer.new(first_path); end

  def initialize(string)
    @path = string
    @question,behavior_string = @path.split(':')
    @behavior_string = behavior_string || ''
  end
  attr_reader :question, :path, :behavior_string

  def number; @question.last ; end

  def behaviors; @behavior_string.split('-').collect{|s| Behavior.send(s)}; end
  def realms; behaviors.map(&:realm); end
  def phases; behaviors.map(&:phase); end

  def free_realms; Realm.all - realms; end
  def free_phases; Phase.all - phases; end
  def free; Behavior.all.select{|b| free_realms.include?(b.realm) && free_phases.include?(b.phase)}; end
  def free?(behavior); free.include?(behavior); end
  def finished?; free.empty?; end

  def next(behavior); question.next + ':' + [@behavior_string, behavior.path].compact_blank.join('-'); end

  def sorted_behaviors; behaviors.sort_by(&:linear_index); end
  def realm_string; sorted_behaviors.map(&:realm).map(&:path).join; end
  def type_index;Type.find_by_realm_string(realm_string).index; end

end
