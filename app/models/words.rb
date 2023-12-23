class Words

def self.issue; {
  'AP'=>'The things I want to accept, but can’t',
  'BP'=>'The things I want to accept, but shouldn’t',
  'AJ'=>'The things I want to change, but can’t',
  'BJ'=>'The things I want to change, but shouldn’t',
}; end #problem.issue
def self.goal; {
  'AP'=>'accept the things I should accept',
  'BP'=>'not accept the things I shouldn’t accept',
  'AJ'=>'change the things I should change',
  'BJ'=>'not change the things I shouldn’t change',
}; end #problem.goal

def self.realms; {
  'S'=>'chemosensory',
  'N'=>'visible',
  'F'=>'audible',
  'T'=>'tangible'
}; end #realm.realms
def self.adjective; {
  'S'=>'chemosensory',
  'N'=>'visual',
  'F'=>'auditory',
  'T'=>'tactile'
}; end #realm.adjective
def self.notice; {
  'S'=>'smell/taste',
  'N'=>'see',
  'F'=>'hear',
  'T'=>'feel'
}; end #realm.notice
def self.appear; {
  'S'=>'taste',
  'N'=>'look',
  'F'=>'sound',
  'T'=>'feel'
}; end #realm.appear
def self.provide; {
  'S'=>'feed',
  'N'=>'show',
  'F'=>'tell',
  'T'=>'give'
}; end #realm.thing
def self.thing; {
  'S'=>'food',
  'N'=>'how',
  'F'=>'why',
  'T'=>'tool'
}; end #realm.thing
def self.take; {
  'S'=>'eat',
  'N'=>'watch',
  'F'=>'hear',
  'T'=>'touch'
}; end #realm.accept
def self.accept; {
  'S'=>'digest',
  'N'=>'learn',
  'F'=>'believe',
  'T'=>'manipulate'
}; end #realm.accept
def self.change; {
  'S'=>'cook',
  'N'=>'rethink',
  'F'=>'rewrite',
  'T'=>'upgrade'
}; end #realm.change
def self.acceptable; {
  'S'=>'nutritious',
  'N'=>'replicable',
  'F'=>'understandable',
  'T'=>'useful'
}; end #realm.acceptable
def self.unacceptable; {
  'S'=>'inedible',
  'N'=>'illogical',
  'F'=>'selfish',
  'T'=>'broken'
}; end #realm.unacceptable

end #Words



