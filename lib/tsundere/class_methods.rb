# class methods

module Tsundere
	module ClassMethods
		attr_reader :look_array, :look_table, :rank_table
		attr_accessor :permission_table, :rank_table

		def attr_tsundere *attributes, opts
			attr_looker *attributes, opts
		end # attr_tsundere

		def attr_looker *attributes, opts
			attr_modifier_thing *attributes, opts.merge( :type => :looker )
		end # attr_looker

		def attr_toucher *attributes, opts
			attr_modifier_thing *attributes, opts.merge( :type => :toucher )
		end # attr_toucher

		# Yes, I realize this function looks like crap, but it's late, I'm tired
		# and this project is due really soon and I need sleep before I die. I'll
		# refactor this later. I swear.
		def attr_modifier_thing *attributes, opts
			@rank_table ||= {}
			@permission_table ||= {}
			[:looker, :toucher].each do |thing|
				@permission_table[thing] ||= {
					:array => [] ,
					:table => {}
				}  # looker
			end  # each thing
			type = opts[:type]
			perm = opts[:as]
			case perm.class.to_s
			when 'Hash'
				perm.each do |key, lvl|
					@rank_table[key] = lvl
					
					ind = permission_table[type][:array].binary_search_raw([lvl, attributes]) { |a1, a2| a1.first <=> a2.first } 
					permission_table[type][:array].insert(ind, [lvl, attributes]).sort! { |a1, a2| a1.first <=> a2.first } 
				end # each perm
			when 'Fixnum', 'Integer', 'Float'
				ind = permission_table[type][:array].binary_search_raw([perm, attributes]) { |a1, a2| a1.first <=> a2.first } 
				permission_table[type][:array].insert(ind, [perm, attributes]).sort! { |a1, a2| a1.first <=> a2.first } 
			when 'String', 'Symbol'
				attributes.each do |attr|
					(permission_table[type][:table][perm] ||= []) << attr
				end # each attr
			end # perm class
		end # attr_toucher
	end # ClassMethods
end # Tsundere