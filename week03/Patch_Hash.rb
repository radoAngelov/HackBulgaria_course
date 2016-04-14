class Hash
  def pick(*keys)
  	select { |key , value| if keys.include? key }
  end

  def pick!(*keys)
    hash = 	Hash.new
    keys.each { |key| hash[key] = self[key] }
    self.replace hash
  end

  def except(*keys)
  	select { |key , value| unless keys.include? key }
  end

  def except!(*keys)
  	hash = self.clone
  	keys.each { |key| hash.delete(key) }
  	self.replace hash
  end

  def compact_values
  	hash = self.clone
  	hash.each_key { |key| hash.delete(key) unless hash[key] }
  	hash
  end

  def compact_values!
  	hash = self.clone
  	hash.each_key { |key| hash.delete(key) unless hash[key] }
  	self.replace hash
  end

  def defaults(hash)
  	new_hash = self.clone
  	hash.each_key { |key| new_hash[key] = hash[key] unless self.has_key? key }
  	new_hash
  end

  def defaults!(hash)
  	new_hash = self.clone
  	hash.each_key { |key| new_hash[key] = hash[key] unless self.has_key? key }
  	self.replace new_hash
  end
end