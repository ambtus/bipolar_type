class Words

def self.phases; {
  'P'=>'depression',
  'J'=>'mania',
  'E'=>'revving up',
  'I'=>'calming down'
}; end #phase.word

def self.description; {
  'P'=>'accept everything',
  'J'=>'change everything',
  'E'=>'want to change things',
  'I'=>'want to accept things',
}; end #phase.description

def self.precursor; {
  'J'=>'Productive Mania<br />change bad things',
  'I'=>'Destructive Mania<br />change good things',
  'P'=>'Healthy Depression<br />accept good things',
  'E'=>'Unhealthy Depression<br />accept bad things',
}; end #phase.precursor

def self.realms; {
  'S'=>'physical',
  'N'=>'mental',
  'F'=>'spritual',
  'T'=>'material'
}; end #realm.realms

def self.notice; {
  'S'=>'taste',
  'N'=>'see',
  'F'=>'hear',
  'T'=>'touch'
}; end #realm.accept

def self.accept; {
  'S'=>'eat',
  'N'=>'follow',
  'F'=>'believe',
  'T'=>'use'
}; end #realm.accept

def self.resource; {
  'S'=>'food',
  'N'=>'rule',
  'F'=>'opinions',
  'T'=>'tool'
}; end #realm.resource
def self.other_resources; {
  'S'=>%w{meats fruits vegetables},
  'N'=>%w{plans directions procedures},
  'F'=>%w{songs stories speeches},
  'T'=>%w{clothes shelters machines},
}; end #realm.resource2

def self.good; {
  'S'=>'nutritious',
  'N'=>'logical',
  'F'=>'loving',
  'T'=>'useful'
}; end #realm.good
def self.bad; {
  'S'=>'junk',
  'N'=>'stupid',
  'F'=>'hateful',
  'T'=>'worthless'
}; end #realm.good

end #Words



