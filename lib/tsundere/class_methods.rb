# class methods

module Tsundere
	module ClassMethods
		attr_reader :look_array, :look_table, :fail_table
		attr_accessor :permission_table, :rank_table

		def attr_tsundere *attributes, opts
			attr_looker *attributes, opts
			if defined? Rails and self.respond_to? :helper_method
				helper_method :tsundere_for
			end # if
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
			@fail_table ||= {}
			[:looker, :toucher].each do |thing|
				@permission_table[thing] ||= {
					:array => [] ,
					:table => {}
				}  # looker
			end  # each thing
			type = opts[:type]
			perm = opts[:as]
			fail = opts[:fail]
			case perm.class.to_s
			when 'Hash'
				perm.each do |key, lvl|
					@rank_table[key] = lvl
					@fail_table[key] ||= fail
					@fail_table[lvl] ||= fail 
					ind = permission_table[type][:array].binary_search_raw([lvl, attributes]) { |a1, a2| a1.first <=> a2.first } 
					permission_table[type][:array].insert(ind, [lvl, attributes]) # .sort! { |a1, a2| a1.first <=> a2.first } 
				end # each perm
			when 'Fixnum', 'Integer', 'Float'
				@fail_table[perm] ||= fail 
				ind = permission_table[type][:array].binary_search_raw([perm, attributes]) { |a1, a2| a1.first <=> a2.first } 
				permission_table[type][:array].insert(ind, [perm, attributes]) # .sort! { |a1, a2| a1.first <=> a2.first } 
			when 'String', 'Symbol'
				@fail_table[perm] ||= fail 
				attributes.each do |attr|
					(permission_table[type][:table][perm] ||= []) << attr
				end # each attr
			end # perm class
		end # attr_toucher
	end # ClassMethods
end # Tsundere