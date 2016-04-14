class Search
  def self.by_type_and_slug(params)
    case type
    when 'brand'
      Brand.where('name LIKE ?', "%#{params[:slug]}%")
    when 'category'
      Category.where('name LIKE ?', "%#{params[:slug]}%")
    when 'product'
      Product.where('name LIKE ?', "%#{params[:slug]}%")
    end
  end

  def self.by_type_property_and_slug(params)
    case type
    when 'brand'
      Brand.where('name LIKE ?', "%#{params[:slug]}%", 'IN ?', "#{params[:property]}")
    when 'category'
      Category.where('name LIKE ?', "%#{params[:slug]}%", 'IN ?', "#{params[:property]}")
    when 'product'
      Product.where('name LIKE ?', "%#{params[:slug]}%", 'IN ?', "#{params[:property]}")
    end 
  end
end