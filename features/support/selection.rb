def whose_whats(whose, whats)
  what = whats.singularize.to_sym
  result = []
  if Realm.all.map(&:name).include?(whose)
    realm = Realm.all.find { |r| r.name == whose }
    Rails.logger.debug realm.inspect
    result = realm.subtypes.map(&what)
  elsif Attitude.all.map(&:name).include?(whose)
    attitude = Attitude.all.find { |r| r.name == whose }
    Rails.logger.debug attitude.inspect
    result = attitude.subtypes.map(&what)
  elsif %w[your my].include?(whose)
    type = whose == 'my' ? Type.my_type : Type.your_type
    Rails.logger.debug type.inspect
    subtypes = type.send(whats)
    result = subtypes.map(&:action)
  else
    Rails.logger.debug whose.constantize
    result = whose.constantize.all.map(&what)
  end
  Rails.logger.debug result
  result
end
