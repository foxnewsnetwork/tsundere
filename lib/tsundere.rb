# Tsundere module
# tsun tsun
# dere dere
require_relative "./tsundere/array"
require_relative "./tsundere/class_methods"
require_relative "./tsundere/instance_methods"
require_relative "./tsundere/imouto"
require_relative "./tsundere/rails_extension"
module Tsundere
	def self.included(base)
		base.extend ClassMethods
		base.extend RailsExtension
	end # self.included
end # Tsundere

if defined? Rails and defined? ActiveSupport
	# ActiveSupport.on_load(:action_view) do
		
	# end # onload
	ActiveSupport.on_load(:action_controller) do
		include Tsundere
	end # 
end # if