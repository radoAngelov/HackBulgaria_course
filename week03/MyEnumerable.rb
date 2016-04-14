module MyEnumerable
  def map
    result = self.clone
    each { |element| result << yield element }
    result
  end

  def filter
    [].tap do |result|
    each { |element| result << element if yield element }
    end
  end

  def reject
    [].tap do |result|
    each { |element| result << element unless yield element }
    end
  end

  def reduce(initial = nil)
    
    each { |element| initial = yield initial , element }
  end

  def any?
    predicate = false
    each { |element| predicate = true if element == true || yield element == true }
    predicate
  end

  def one?
    
  end

  def all?
    predicate = false
    each { |element| true if yield element }
    predicate
  end

  # Yield each consequative n elements.
  def each_cons(n)
    # Your code goes here.
  end

  def include?(element)
    predicate = false
    each { |position| predicate = true if position == element }
    predicate
  end

  # Count the occurences of an element in the collection. If no element is
  # given, count the size of the collection.
  def count(element = nil)
    
  end

  # Count the size of the collection.
  def size
    Integer.new.tap do |count|
      each { |element| count += 1 }
    end
  end

  # Groups the collection by result of the block.
  # Returns a hash where the keys are the evaluated
  # result from the block and the values are arrays
  # of elements in the collection that correspond to
  # the key.
  def group_by
    {}.tap do |hash|
      array = []
      each do |element| 
        array << element if yield element
        hash[yield element] = array
       end
    end
  end

  def min
    Object.new do |obj|
      obj = self.first
      each { |element| obj = element if obj > element }
  end

  def min_by
    Object.new.tap do |min_element|
      each { |element| min_element = element  if (yield element) < (yield element.next) }
    end
  end

  def max
    Object.new do |obj|
      obj = self.first
      each { |element| obj = element if obj < element }    
  end

  def max_by
    Object.new.tap do |min_element|
      each { |element| min_element = element unless (yield element) < (yield element.next) }
    end    
  end

  def take(n)
    index = 0
    [].tap do |arr|
      each do |element|
        while index < 0
          arr << element
          index += 1
        end
      end
  end

  def take_while
    [].tap do |arr|
      each { |element| arr << element if yield element }
    end
  end

  def drop(n)
    index = 0
    [].tap do |arr|
      arr = self.clone
      arr.each do |element|
        while index < n
          arr >> element
          index += 1
        end
      end
  end

  def drop_while
    [].tap do |arr|
      arr = self.clone
      arr.each { |element| arr >> element if yield element }
  end
end