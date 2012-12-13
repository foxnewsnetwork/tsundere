
# Imouto class; aka, the tsundere proxy
module Tsundere
	class Imouto
		def initialize parent, level
			@parent = parent
			@level = level
		end # initialize

		def method_missing meth, *args, &block
			if @parent.respond_to? meth 
				if :[] == meth
					if @parent.dere_for? @level, args.inject("") { |mem, arg| mem += arg.to_s }.to_sym
						@parent[*args, &block] unless block.nil?
						@parent[*args] if block.nil?
					else
						return "Sorry #{@level}, access to #{meth} is denied!"	
					end # if
				elsif :[]= == meth
					tail = args.pop
					
					if @parent.dere_for? @level, args.inject("") { |mem, arg| mem += arg.to_s }.to_sym
						@parent[*args] = tail
					else
						return "Sorry #{@level}, access to #{meth} is denied!"
					end # if
				elsif @parent.dere_for? @level, meth
					@parent.send(meth, *args, &block) unless block.nil?
					@parent.send(meth, *args) if block.nil?
				else
					return "Sorry #{@level}, access to #{meth} is denied!"
				end # if-else
			else
				super
			end 
		end # method_missing

		def respond_to? meth
			if @parent.dere_for? @level, meth 
				@parent.respond_to? meth
			elsif :[] == meth or :[]= == meth
				@parent.respond_to? meth
			else
				false
			end # if-dere
		end # meth
	end # imouto
end # Tsundere