
# Imouto class; aka, the tsundere proxy
module Tsundere
	class Imouto
		def initialize parent, level
			@parent = parent
			@level = level
		end # initialize

		def method_missing meth, *args, &block
			conditions = []
			conditions << lambda do
				:[] == meth and @parent.dere_for? @level, process_args( *args )
			end
			conditions << lambda do
				:[]= == meth and @parent.dere_for? @level, process_args( *args[0..-2] )
			end
			conditions << lambda do
				@parent.dere_for? @level, meth 
			end
			if @parent.respond_to? meth 
				if conditions.inject(false) { |mem, c| mem or c.call }
					case meth
					when :[]
						@parent[*args, &block] unless block.nil?
						@parent[*args] if block.nil?
					when :[]=
						tail = args.pop 

						@parent[*args] = tail
					else
						@parent.send(meth, *args, &block) unless block.nil?
						@parent.send(meth, *args) if block.nil?
					end # meth
				else
					return @parent.tsun_for @level
				end # if conditions inject
			else
				super
			end # if has method
		end # method_missing

		def respond_to? meth
			if @parent.dere_for? @level, meth 
				@parent.respond_to? meth
			elsif :[] == meth or :[]= == meth
				@parent.respond_to? meth
			else
				false
			end # if-dere
		end # respond_to

		private

		def process_args *args
			args.inject("") { |mem, arg| mem += arg.to_s }.to_sym
		end # process_args
	end # imouto
end # Tsundere