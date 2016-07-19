class Type
  attr_reader :name, :url
  attr_accessor :super_effective, :not_very_effective, :zero_effect, :strong_against, :weak_against

  @@all = []

  def initialize name, url
    @name = name
    @@all << self
    @url = url
    @super_effective = []
    @not_very_effective = []
    @zero_effect = []
    @strong_against = []
    @weak_against = []
  end

  def self.find_by_name name
    self.all.detect{|type| type.name == name}
  end

  def self.all
    @@all
  end

end