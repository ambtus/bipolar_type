def whose_whats(whose, whats)

  result = []
  if Realm.all.map(&:name).include?(whose)
    realm=Realm.all.find { | r| r.name == whose }
    Rails.logger.debug realm.inspect
    result=realm.subtypes.map(&:act)
  elsif %w{your my}.include?(whose)
    type = whose == 'my' ? Type.my_type : Type.your_type
    Rails.logger.debug type.inspect
    subtypes = whats == "do's" ? type.subtypes : type.subtypes.map(&:flop)
    result = subtypes.map(&:act)
  else
    Rails.logger.debug whose.constantize
    what = whats.singularize
    result = whose.constantize.all.map(&what.to_sym)
  end
  Rails.logger.debug result
  return result

end
