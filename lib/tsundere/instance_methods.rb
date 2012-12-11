# tsundere instance module
module Tsundere
	def tsundere_for(duck)
		level = p_retrieve_level_or_rank duck
		Imouto.new self, level 
	end # tsundere_for

	def dere_for? lvl, meth
		return false if lvl.nil?
		if self.class.rank_table[lvl].is_a? Array and self.class.rank_table[lvl].include? meth
			return true
		else
			level = self.class.rank_table[lvl.to_sym] if lvl.is_a? Symbol or lvl.is_a? String
			level ||= lvl
			start_ind = self.class.permission_table[:looker][:array].binary_search_raw([level, [meth]], :left => true) { |a1, a2| a1.first <=> a2.first }
			flag = false
			(start_ind+1).times do |n|
				flag = self.class.permission_table[:looker][:array][n].last.include? meth
				break flag if flag
			end # times
			return flag
		end # if-else
	end # dere_for?

	private
	def p_retrieve_level_or_rank duck
		case duck.class.to_s
		when String.to_s, Fixnum.to_s, Float.to_s, Integer.to_s, Symbol.to_s
			duck
		when Hash.to_s
			duck[:level] if duck.has_key? :level
			duck[:rank] if duck.has_key? :rank
		else
			duck.level if duck.respond_to? :level
			duck.rank if duck.respond_to? :rank
		end # duck class
	end # level or rank
end # Tsundere