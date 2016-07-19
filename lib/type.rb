class Type
  attr_reader :name, :url

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


end