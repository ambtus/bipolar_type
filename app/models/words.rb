class Words

def self.reasons; {'GE'=>'needs to get less energy', 'UE'=>'needs to get more energy', 'US'=>'needs to use less strength', 'GS'=>'needs to use more strength'}; end

def self.solutions; {'GE'=>'GetStrength instead of GetEnergy', 'UE'=>'GetEnergy in addition to GetStrength', 'US'=>'UseEnergy instead of UseStrength', 'GS'=>'UseStrength as well as UseEnergy'}; end

def self.start_seasons; {'GE'=>'Winter', 'UE'=>'Spring', 'US'=>'Summer', 'GS'=>'Fall'}; end
def self.month_ranges; {'GE'=>'Jan~Mar', 'UE'=>'Apr~Jun', 'US'=>'Jul~Sep', 'GS'=>'Oct~Dec'}; end

def self.seasons; {'GE'=>'Late Winter', 'UE'=>'Early Summer', 'US'=>'Late Summer', 'GS'=>'Early Winter'}; end
def self.months; {'GE'=>'February', 'UE'=>'May', 'US'=>'August', 'GS'=>'November'}; end

def self.moon_symbols; {'GE'=>'🌒', 'UE'=>'🌔', 'US'=>'🌖', 'GS'=>'🌘'}; end

def self.moons; {'GE'=>'Waxing🌒Crescent', 'UE'=>'Waxing🌔Gibbous', 'US'=>'Waning🌖Gibbous', 'GS'=>'Waning🌘Crescent'}; end
def self.days; {'GE'=>'Monday', 'UE'=>'Tuesday', 'US'=>'Thursday', 'GS'=>'Friday'}; end

def self.times; {'GE'=>'Sunrise', 'UE'=>'Forenoon', 'US'=>'Afternoon', 'GS'=>'Sunset'}; end
def self.hours; {'GE'=>'8am', 'UE'=>'12noon', 'US'=>'4pm', 'GS'=>'8pm'}; end
def self.hour_ranges; {'GE'=>'6am~10am', 'UE'=>'10am~2pm', 'US'=>'2pm~6pm', 'GS'=>'6pm~10pm'}; end

def self.gets; {'P'=>'eat', 'M'=>'learn', 'A'=>'listen', 'F'=>'earn'}; end
def self.uses; {'P'=>'exercise', 'M'=>'think', 'A'=>'communicate', 'F'=>'spend'}; end
def self.thins; {'P'=>'anorexic', 'M'=>'amnesic', 'A'=>'suicidal', 'F'=>'poor'}; end
def self.fats; {'P'=>'obese', 'M'=>'fatheaded', 'A'=>'homicidal', 'F'=>'rich'}; end

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

'GAE'=>'listen to music',
'UAE'=>'talk',
'UAS'=>'write',
'GAS'=>'read',

'GFE'=>'earn cash',
'UFE'=>'spend cash',
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



