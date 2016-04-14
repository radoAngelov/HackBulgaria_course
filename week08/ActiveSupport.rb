class Object
  def blank?
    if is_a?(String)
      true if self =~ /^\s+$/
    elsif respond_to?(:empty?) == false
      true
    else
      empty?
    end
  end

  def present?
    !blank?
  end

  def presence
    if present?
      self
    else 
      nil
    end
  end

  def try(method_name)
    if nil?
      nil
    else
      send(method_name)
    end
  end
end

class StringInquirer < String
  def method_missing(method)
    if self == method.to_s.chop
      true
    else
      false
    end
  end
end

class String
  def inquiry
    StringInquirer.new(self)
  end
end

