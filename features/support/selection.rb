def whose_whats(whose, whats)

  result = []
  if Realm.all.map(&:name).include?(whose)
    realm=Realm.all.find { | r| r.name == whose }
    Rails.logger.debug realm.inspect
    what = whats.singularize.to_sym
    result=realm.subtypes.map(&what)
  elsif %w{your my}.include?(whose)
    type = whose == 'my' ? Type.my_type : Type.your_type
    Rails.logger.debug type.inspect
    subtypes = case whats
      when "dos"
        type.subtypes
      when "wants"
        type.subtypes.map(&:flip)
      when "don'ts"
        type.subtypes.map(&:flop)
      when "can'ts"
        type.subtypes.map(&:opposite)
    end
    result = subtypes.map(&:action)
  else
    Rails.logger.debug whose.constantize
    what = whats.singularize
    result = whose.constantize.all.map(&what.to_sym)
  end
  Rails.logger.debug result
  return result

end
