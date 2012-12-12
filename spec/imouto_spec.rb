require 'spec_helper'

class SchoolGirl
	include Tsundere
	attr_tsundere :show_up, :as => { :user => 1 }
	attr_tsundere :brush_teeth, :as => { :oniichan => 2 }

	def show_up
		1
	end # show_up

	def brush_teeth
		2
	end # brush
end # StereotypicalLoli

describe SchoolGirl do 
	before :each do 
		@tsukihi = SchoolGirl.new
	end # each
	it "should respond to show_up" do 
		@tsukihi.should respond_to :show_up
	end # it
	it "should proxy correctly" do 
		@tsukihi.tsundere_for(:user).should respond_to :show_up
	end # it
	it "should not allow anyone to do that teeth scene" do 
		@tsukihi.tsundere_for(:user).should_not respond_to :brush_teeth
	end # it
	it "should allow oniichan to brush teeth" do 
		@tsukihi.tsundere_for(:oniichan).should respond_to :brush_teeth
		@tsukihi.tsundere_for(:oniichan).should respond_to :show_up
	end # it
end # SchoolGirl