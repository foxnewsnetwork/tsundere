
# Array extension
class Array

	# binary_search_raw
	# param1: should be comparable against elements in the array
	# if not, provide a block which can be used to do equals
	# returns the index with the target if possible, but will
	# otherwise return the index of the element that is the smallest
	# element larger than the target. It's raw because it does
	# not check if the array is sorted or not
	def binary_search_raw target, opts={}
		right_flag = true
		right_flag = false if opts[:left]
		if block_given?
			return p_bisearch_internal( 0, count-1, target, right_flag) do |a,b|
				yield a,b
			end # return
		else
			return p_bisearch_internal( 0, count-1, target, right_flag ) do |a,b| 
				a <=> b 
			end
		end
	end # binary_search


	# each2 is exactly as the name sounds
	# it takes from an array two at a time
	# until it hits the end of the array
	# as such, all the items except for first
	# and last are observed twice
	def each2 &block
		count.times do |n|
			yield self[n], self[n+1] unless n + 1 == count
		end # count n
	end # each2

	private
	def p_bisearch_internal s, f, target, right_flag, &eq

		mid = (f + s)/ 2
		return f if f == s
		return s if count < 2
		result = yield target, self[mid]
		return mid if 0 == result
		if s + 1 == f 
			if right_flag
				return s if yield(target, self[s]) <= 0 # target == self[s] or target < self[s] 
				return f 
			else
				return f if yield(target, self[f]) >= 0 # target == self[f] or target > self[f] 
				return s 
			end
		end # if
		return p_bisearch_internal s, mid, target, right_flag, &eq if -1 == result
		return p_bisearch_internal mid, f, target, right_flag, &eq if 1 == result
	end # p_bisearch_internal
end # Array