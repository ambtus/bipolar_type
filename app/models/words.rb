class Words

def self.seasons; {'GE'=>'Late Winter', 'UE'=>'Early Summer', 'US'=>'Late Summer', 'GS'=>'Early Winter'}; end
def self.months; {'GE'=>'February', 'UE'=>'May', 'US'=>'August', 'GS'=>'November'}; end
def self.moons; {'GE'=>'Waxing🌒Crescent', 'UE'=>'Waxing🌔Gibbous', 'US'=>'Waning🌖Gibbous', 'GS'=>'Waning🌘Crescent'}; end
def self.days; {'GE'=>'Monday', 'UE'=>'Tuesday', 'US'=>'Thursday', 'GS'=>'Friday'}; end
def self.times; {'GE'=>'Morning', 'UE'=>'Midday', 'US'=>'Afternoon', 'GS'=>'Evening'}; end
def self.hours; {'GE'=>'8am', 'UE'=>'12noon', 'US'=>'4pm', 'GS'=>'8pm'}; end

def self.noun_words; {'P'=>'foods', 'M'=>'truths', 'A'=>'stories', 'F'=>'money'}; end
def self.verb_words; {
'GPE'=>'eat plant-based',
'UPE'=>'gather plant',
'UPS'=>'hunt animal',
'GPS'=>'eat animal-based',

'GME'=>'see past',
'UME'=>'visualize current',
'UMS'=>'visualize possible',
'GMS'=>'see emerging',

'GAE'=>'listen to',
'UAE'=>'tell',
'UAS'=>'write',
'GAS'=>'read',

'GFE'=>'take',
'UFE'=>'give',
'UFS'=>'promise',
'GFS'=>'collect' }
end

def self.short_phrase; {
'GPE'=>'eat carbs',
'UPE'=>'walk',
'UPS'=>'run',
'GPS'=>'eat protein',

'GME'=>'look',
'UME'=>'know',
'UMS'=>'imagine',
'GMS'=>'watch',

'GAE'=>'listen',
'UAE'=>'talk',
'UAS'=>'write',
'GAS'=>'read',

'GFE'=>'earn cash',
'UFE'=>'pay cash',
'UFS'=>'borrow',
'GFS'=>'invest' }
end #short_phrase

def self.prefer; {
'GPE'=>'sweet foods',
'UPE'=>'long slow hikes',
'UPS'=>'short fast sprints',
'GPS'=>'savory foods',

'GME'=>'the trees',
'UME'=>'synthesizing facts',
'UMS'=>'predicting consequences',
'GMS'=>'the forest',

'GAE'=>'harmony',
'UAE'=>'singing in the choir',
'UAS'=>'writing the sermon',
'GAS'=>'meaning',

'GFE'=>'large but sporadic income',
'UFE'=>'paying upfront',
'UFS'=>'paying over time',
'GFS'=>'small but steady income'
}
end #prefer

def self.choose_the; {
'GPE'=>'potatoes',
'UPE'=>'easy but prolonged exercise',
'UPS'=>'hard but short exercise',
'GPS'=>'meat',

'GME'=>'specific details',
'UME'=>'colorful pictures',
'UMS'=>'moving pictures',
'GMS'=>'general outlines',

'GAE'=>'the melody',
'UAE'=>'heartfelt story',
'UAS'=>'moral story',
'GAS'=>'the lyrics',

'GFE'=>'short-term profits',
'UFE'=>'lump sum payment',
'UFS'=>'many small payments',
'GFS'=>'long-term profits'
}
end #choose_the

def self.better_at; {
'GPE'=>'digesting starches',
'UPE'=>'endurance training',
'UPS'=>'strength training',
'GPS'=>'digesting amino acids',

'GME'=>'remembering exceptions',
'UME'=>'identifying correlation',
'UMS'=>'identifying causation',
'GMS'=>'remembering rules',

'GAE'=>'accepting the emotions',
'UAE'=>'making yourself heard',
'UAS'=>'making yourself understood',
'GAS'=>'accepting the morals',

'GFE'=>'providing labor',
'UFE'=>'owning',
'UFS'=>'leasing',
'GFS'=>'providing capital'
}
end #better_at

def self.result; {
'GPE'=>'augment your fat cells',
'UPE'=>'deplete your fat cells',
'UPS'=>'exhaust your muscles',
'GPS'=>'build your muscles',

'GME'=>'augmentyour knowledge',
'UME'=>'deplete your knowledge',
'UMS'=>'exhaust your mental models',
'GMS'=>'build your mental models',

'GAE'=>'augment your mood',
'UAE'=>'depelete your mood',
'UAS'=>'exhuast your vocabulary',
'GAS'=>'build your vocabulary',

'GFE'=>'augment your savings',
'UFE'=>'depelete your savings',
'UFS'=>'exhaust your credit',
'GFS'=>'build your credit'
}
end #result

end #Words



