###
# Example usage code for Tsundere
###

# Helper-View injection in rails
# Original code

# Your model
class Invoice < ActiveRecord::Base
	...
end # Invoice

# Some helper you have
module PageHelper
	def generate_tileview_hash invoice
		output = {
			:title => invoice.title ,
			:content => invoice.text ,
			...
		}
	end # generate_tile_hash
end # PageHelper

# Your view
=render "shared/tileview", :tile => generate_tileview_hash(@invoice)


## Here, your boss says he needs a permission system so that
# only level 3 (accounting) and up can see the sales prices
# on any given invoice
# Your fixed model
class Invoice < ActiveRecord::Base
	attr_tsundere :price, :fail => "Access-denied", :as => { :acounting => 3 }
end # Invoice

# Your view
=render "shared/tileview", :tile => generate_tileview_hash(@invoice.tsundere_for(current_user))