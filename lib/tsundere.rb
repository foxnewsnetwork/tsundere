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