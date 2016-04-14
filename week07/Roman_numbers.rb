module Roman

  @@roman_literals = {
    'I' => 1,
    'V' => 5,
    'X' => 10,
    'L' => 50,
    'C' => 100,
    'D' => 500,
    'M' => 1000
  }

  def self.const_missing(number)
    result, array = 0, []

    number.to_s.each_char { |char| array << char.to_s }
    
    array.each_index do |index|
      if @@roman_literals.key? "#{array[index]}"
        if index < array.length - 1 && @@roman_literals[array[index]] < @@roman_literals[array[index + 1]]
          result -= @@roman_literals[array[index]]
        else
          result += @@roman_literals[array[index]]
        end
      end
    end
    p result
  end
end

Roman::XXX