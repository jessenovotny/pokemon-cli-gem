class Scraper
  def get_page
    page = Nokogiri::HTML(open("http://pokemondb.net/type"))
  end

  def make_types
    self.get_page.css(".type-icon-list a").each do |type|
      Type.new(type.text, "http://pokemondb.net#{type["href"]}")
    end
  end

  def make_relationships
    self.make_types

    Type.all.each do |type|
      page = Nokogiri::HTML(open("#{type.url}")).css(".colset .col")[0]
      page.css("p").each_with_index do |rel, index|
        
        if rel.text.include?("moves are super-effective")
          super_effective(type, index, page)
        
        elsif rel.text.include?("moves are not very effective")
          not_very_effective(type, index, page)
        
        elsif rel.text.include?("moves have no effect")
          no_effect(type, index, page)
        
        elsif rel.text.include?("types have no effect")
          not_effected_by(type, index, page)
        
        elsif rel.text.include?("types are not very effective")
          strong_against(type, index, page)
        
        elsif rel.text.include?("types are super-effective")
          weak_against(type, index, page)
        end
      end
    end
  end

  def super_effective type, index, page
    page.css('div')[index].text.strip.split.each do |other_type| 
      type.super_effective << Type.find_by_name(other_type) if !type.super_effective.include?(Type.find_by_name(other_type))
      Type.find_by_name(other_type).weak_against << type if !Type.find_by_name(other_type).weak_against.include?(type)
    end
  end

  def not_very_effective type, index, page
    page.css('div')[index].text.strip.split.each do |other_type| 
      type.not_very_effective << Type.find_by_name(other_type) if !type.not_very_effective.include?(Type.find_by_name(other_type))
      Type.find_by_name(other_type).strong_against << type if !Type.find_by_name(other_type).strong_against.include?(type)
    end
  end

  def no_effect type, index, page
    page.css('div')[index].text.strip.split.each do |other_type| 
      type.no_effect << Type.find_by_name(other_type) if !type.no_effect.include?(Type.find_by_name(other_type))
      Type.find_by_name(other_type).not_effected_by << type if !Type.find_by_name(other_type).not_effected_by.include?(type)
    end
  end

  def not_effected_by type, index, page
    page.css('div')[index].text.strip.split.each do |other_type| 
      type.not_effected_by << Type.find_by_name(other_type) if !type.not_effected_by.include?(Type.find_by_name(other_type))
      Type.find_by_name(other_type).no_effect << type if !Type.find_by_name(other_type).no_effect.include?(type)
    end
  end

  def strong_against type, index, page
    page.css('div')[index].text.strip.split.each do |other_type| 
      type.strong_against << Type.find_by_name(other_type) if !type.strong_against.include?(Type.find_by_name(other_type))
      Type.find_by_name(other_type).not_very_effective << type if !Type.find_by_name(other_type).not_very_effective.include?(type)
    end
  end

  def weak_against type, index, page
    page.css('div')[index].text.strip.split.each do |other_type| 
      type.weak_against << Type.find_by_name(other_type) if !type.weak_against.include?(Type.find_by_name(other_type))
      Type.find_by_name(other_type).strong_against << type if !Type.find_by_name(other_type).strong_against.include?(type)
    end
  end

end
