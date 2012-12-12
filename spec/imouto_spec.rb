require 'spec_helper'

class SchoolGirl
	include Tsundere
	attr_tsundere :show_up, :as => { :user => 1 }

	def show_up
		1
	end # show_up
end # StereotypicalLoli

describe SchoolGirl do 
	before :each do 
		@tsukihi = SchoolGirl.new
	end # each
	it "should respond to show_up" do 
		@tsukihi.should respond_to :show_up
	end # it
end # SchoolGirl