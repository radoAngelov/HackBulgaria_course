class Array

	def to_hash
		Hash.new.tap do |hash|
			each { |element| hash[element[0]] = element[1] }
		end
	end

	def index_by
		Hash.new.tap do |hash|
			each { |element| hash[yield element] = element }
		end
	end

	def subarray_count(subarray)
		result = 0
		each_index do |index|
			if self[index] == subarray[0]
				is_same , i = true , 1
				while i < subarray.length
					is_same = false if index + i > self.length or subarray[i] != self[index + i]
					i += 1
				end
				result += 1 if is_same
			end
		end
		result
	end

	def occurences_count
		
end