class Words


def self.seasons
{'GE'=>'Late Winter', 'UE'=>'Early Summer', 'US'=>'Late Summer', 'GS'=>'Early Winter'}
end
def self.months
{'GE'=>'February', 'UE'=>'May', 'US'=>'August', 'GS'=>'November'}
end
def self.moons
{'GE'=>'Waxing🌒Crescent', 'UE'=>'Waxing🌔Gibbous', 'US'=>'Waning🌖Gibbous', 'GS'=>'Waning🌘Crescent'}
end
def self.days
{'GE'=>'Monday', 'UE'=>'Tuesday', 'US'=>'Thursday', 'GS'=>'Friday'}
end
def self.times
{'GE'=>'Morning', 'UE'=>'Midday', 'US'=>'Afternoon', 'GS'=>'Evening'}
end
def self.hours
{'GE'=>'8am', 'UE'=>'12noon', 'US'=>'4pm', 'GS'=>'8pm'}
end

def self.imbalances
{
'GP'=>%w{obese fat overweight heavy chubby},
'UP'=>%w{anorexic skinny underweight scrawny bony},
'GM'=>%w{stupid fat-headed dull dense slow-witted},
'UM'=>%w{crazy forgetful impractical unrealistic idealistic},
'GA'=>%w{homicidal arrogant over-confident opinionated prejudiced},
'UA'=>%w{suicidal pessimistic defeatist wishy-washy demoralized},
'GF'=>%w{rich miserly penny-pinching stingy close-fisted},
'UF'=>%w{poor spendthrift broke penniless destitute}
}
end

def self.noun_words; {'P'=>'food', 'M'=>'true', 'A'=>'words', 'F'=>'assets'}; end

def self.verb_words
{
'GPE'=>'eat plant-based',  'GME'=>'what was',     'GAE'=>'listen to','GFE'=>'sell',
'UPE'=>'gather plants for','UME'=>'what is',      'UAE'=>'speak',    'UFE'=>'buy',
'UPS'=>'hunt animals for', 'UMS'=>'what might be','UAS'=>'write',    'UFS'=>'pledge',
'GPS'=>'eat animal-based', 'GMS'=>'what will be', 'GAS'=>'read',     'GFS'=>'loan'
}
end

def self.examples
{
'GPE'=>%Q| (eat carbs)
sensitive to sweet and bitter
digest starches & sugars
(re)build your fat cells|,
'GME'=>%Q| (research)
sensitive to color and detail
analyze specific facts
(re)build your memories|,
'GAE'=>%Q| (listen to music)
sensitive to continuous sounds
understand the emotion
(re)build your mood|,
'GFE'=>%Q| (earn cash)
collect wages or profits
collect a variable income
(re)build your savings|,
'UPE'=>%Q| (walk)
endurance training
long slow hikes
use your fat cells|,
'UME'=>%Q| (know)
intuit or guess the truth
create an idea or picture
use your memories|,
'UAE'=>%Q| (talk)
share your feelings
laugh or sing
use your emotions|,
'UFE'=>%Q| (pay cash)
checks and EFTs
pay upfront
use your savings|,
'UPS'=>%Q| (run)
strength training
short fast sprints
use your muscles|,
'UMS'=>%Q| (think)
imagine or predict the truth
create a theory or schedule
use your mental models|,
'UAS'=>%Q| (write)
share your story
explain your values
use your vocabulary|,
'UFS'=>%Q| (borrow)
loans and mortgages
pay over time
use your credit|,
'GPS'=>%Q| (eat protein)
sensitive to umami and sour
digest amino acids
(re)build your muscles|,
'GMS'=>%Q| (watch)
sensitive to shadow and movement
analyze general effects
(re)build your mental models|,
'GAS'=>%Q| (read)
sensitive to discreet sounds
understand the meaning
(re)build your vocabulary|,
'GFS'=>%Q| (lend)
collect a salary or interest
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
