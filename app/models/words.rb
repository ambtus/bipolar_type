class Words


def self.seasons; {'GE'=>'Late Winter', 'UE'=>'Early Summer', 'US'=>'Late Summer', 'GS'=>'Early Winter'}; end
def self.months; {'GE'=>'February', 'UE'=>'May', 'US'=>'August', 'GS'=>'November'}; end
def self.moons; {'GE'=>'Waxing🌒Crescent', 'UE'=>'Waxing🌔Gibbous', 'US'=>'Waning🌖Gibbous', 'GS'=>'Waning🌘Crescent'}; end
def self.days; {'GE'=>'Monday', 'UE'=>'Tuesday', 'US'=>'Thursday', 'GS'=>'Friday'}; end
def self.times; {'GE'=>'Morning', 'UE'=>'Midday', 'US'=>'Afternoon', 'GS'=>'Evening'}; end
def self.hours; {'GE'=>'8am', 'UE'=>'12noon', 'US'=>'4pm', 'GS'=>'8pm'}; end

def self.noun_words; {'P'=>'food', 'M'=>'true', 'A'=>'stories', 'F'=>'assets'}; end

def self.verb_words; {
'GPE'=>'eat plant-based',
'GME'=>'what was',
'GAE'=>'hear',
'GFE'=>'sell',
'UPE'=>'gather plants for',
'UME'=>'what is',
'UAE'=>'tell',
'UFE'=>'buy',
'UPS'=>'hunt animals for',
'UMS'=>'what might be',
'UAS'=>'preserve',
'UFS'=>'pledge',
'GPS'=>'eat animal-based',
'GMS'=>'what will be',
'GAS'=>'understand',
'GFS'=>'loan' }
end

def self.short_phrase; {
'GPE'=>'eat carbs',
'GME'=>'research facts',
'GAE'=>'listen to music',
'GFE'=>'earn cash',
'UPE'=>'walk or jog',
'UME'=>'know',
'UAE'=>'sing or shout',
'UFE'=>'pay cash',
'UPS'=>'lift weights',
'UMS'=>'think',
'UAS'=>'write',
'UFS'=>'borrow',
'GPS'=>'eat protein',
'GMS'=>'watch results',
'GAS'=>'read',
'GFS'=>'earn credit' }
end

def self.examples; {
'GPE'=>%Q|enjoy sweet foods but dislike bitter foods
choose the potatoes over the meat
easily digest starches & sugars
(re)build your fat cells|,
'UPE'=>%Q|endurance training
prefer long slow hikes
easy and prolonged exercise
use your fat cells|,
'UPS'=>%Q|strength training
prefer short fast sprints
hard and intense exercise
use your muscles|,
'GPS'=>%Q|enjoy savory foods but dislike sour foods
choose the meat over the potatoes
easily digest amino acids
(re)build your muscles|,

'GME'=>%Q|enjoy colors but dislike shadows
choose the trees over the forest
remember specific facts
(re)build your knowledge|,
'UME'=>%Q|intuit or guess the truth
prefer creating detailed pictures
visualize an image or picture
use your knowledge|,
'UMS'=>%Q|imagine or predict the truth
prefer creating sequential pictures
visualize a theory or plan
use your mental models|,
'GMS'=>%Q|enjoy movement but dislike details
choose the forest over the trees
remember general effects
(re)build your mental models|,

'GAE'=>%Q|enjoy harmony but dislike dissonance
choose the melody over the lyrics
understand the emotions
(re)build your mood|,
'UAE'=>%Q|share your emotions
prefer singing in the choir
make yourself heard
use your mood|,
'UAS'=>%Q|share your values
prefer preaching from the pulpit
make yourself understood
use your vocabulary|,
'GAS'=>%Q|enjoy language but dislike bad grammar
choose the lyrics over the melody
understand the values
(re)build your vocabulary|,

'GFE'=>%Q|enjoy winning but dislike losing
choose the short-term gains
collect a variable income
(re)build your savings|,
'UFE'=>%Q|pay by check or EFT
prefer paying upfront
make one large payment
use your savings|,
'UFS'=>%Q|pay using loans or mortgages
prefer paying over time
make many small payments
use your credit|,
'GFS'=>%Q|enjoy lending but dislike defaulters
choose the long-term gains
collect a steady income
(re)build your credit|
}
end #examples

end #Words



# [Behavior.map(&:symbol), (1..16).to_a].transpose.to_h
# {
# 'GPE'=>1,  'GME'=>2,  'GAE'=>3,  'GFE'=>4,
# 'UPE'=>5,  'UME'=>6,  'UAE'=>7,  'UFE'=>8,
# 'UPS'=>9,  'UMS'=>10, 'UAS'=>11, 'UFS'=>12,
# 'GPS'=>13, 'GMS'=>14, 'GAS'=>15, 'GFS'=>16
# }

# [Behavior.map(&:symbol).map(&:chop).uniq, (1..8).to_a].transpose.to_h
# {'GP'=>1, 'GM'=>2, 'GA'=>3, 'GF'=>4,'UP'=>5, 'UM'=>6, 'UA'=>7, 'UF'=>8}

# [Phase.map(&:symbol), (1..4).to_a].transpose.to_h
# {'GE'=>1, 'UE'=>2, 'US'=>3, 'GS'=>4}
