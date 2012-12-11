
# Imouto class; aka, the tsundere proxy
module Tsundere
	class Imouto
		def initialize parent, level
			@parent = parent
			@level = level
		end # initialize

		def method_missing meth, *args, &block
			if @parent.respond_to? meth 
				if @parent.dere_for? @level, meth
					@parent.send(meth, *args, &block) unless block.nil?
					@parent.send(meth, *args) if block.nil?
				else
					return "Sorry #{@level}, you can't #{meth} me!"
				end # if-else
			else
				super
			end 
		end # method_missing
	end # imouto
end # Tsundere