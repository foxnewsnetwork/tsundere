module Tsundere
	module RailsExtension
		# Watch for rails
		if defined? Rails and respond_to? :helper_method
			helper_method :tsundere_for
		end # if
	end # RailsExt

end # Tsundere