class Scraper

  def get_page
    Nokogiri::HTML(open("http://pokemondb.net/type"))
  end

  def make_types
    self.get_page.css(".type-icon-list a").each do |type|
      Type.new(type.text, "http://pokemondb.net#{type["href"]}")
    end
  end

  def make_relationships
    self.make_types

    Type.all.each do |type|
      hash = {
        "#{type.name} moves are super-effective against:" => :super_effective,
        "#{type.name} moves are not very effective against:" => :not_very_effective,
        "#{type.name} moves have no effect on:" => :no_effect,
        "These types have no effect on #{type.name} Pokémon:" => :not_effected_by,
        "These types are not very effective against #{type.name} Pokémon:" => :strong_against,
        "These types are super-effective against #{type.name} Pokémon:" => :weak_against
        }
      page = Nokogiri::HTML(open("#{type.url}")).css(".colset .col")[0]
      page.css("p").each_with_index do |rel_string, index|
        rel_sym = hash[rel_string.text.strip]
        if rel_sym != nil
          page.css('div')[index].text.strip.split.each do |other_type_name| 
            type.send(rel_sym) << Type.find_by_name(other_type_name) if !type.send(rel_sym).include?(Type.find_by_name(other_type_name))
          end
        end
      end
    end
  end
end
