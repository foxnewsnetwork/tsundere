# Tsundere module
# tsun tsun
# dere dere
require_relative "./tsundere/array"
require_relative "./tsundere/class_methods"
require_relative "./tsundere/instance_methods"
require_relative "./tsundere/imouto"
module Tsundere
	def self.included(base)
		base.extend ClassMethods
	end # self.included
end # Tsundere

if defined? Rails and defined? ActiveSupport
	ActiveSupport.on_load(:action_controller) do
		include Tsundere
	end # onload
end # if