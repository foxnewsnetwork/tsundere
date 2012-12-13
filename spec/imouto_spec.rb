require 'spec_helper'

class SchoolGirl
	include Tsundere
	attr_tsundere :show_up, :fail => "you are a faggot", :as => { :user => 1 }
	attr_tsundere :brush_teeth, :fanservice, :as => { :oniichan => 2 }

	def show_up
		1
	end # show_up

	def brush_teeth
		2
	end # brush

	def []( k)
		@internal[k]
	end # getter

	def []=( k, j)
		@internal ||= {}
		@internal[k] = j
	end # setter
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
	[:user, :oniichan].each do |character|
		[:[], :[]=].each do |fun|
			it "should have the getter" do 
				@tsukihi.should respond_to fun
			end # it
			it "should have the getter" do 
				@tsukihi.tsundere_for(character).should respond_to fun
			end # it		
		end # each fun
	end # each character
	describe "[]" do 
		before :each do 
			@tsukihi.tsundere_for(:oniichan)[:fanservice] = true
		end # each
		it "should only fanservice oniichan" do 
			@tsukihi[:fanservice].should eq true
			@tsukihi.tsundere_for(:oniichan)[:fanservice].should eq true
		end # it
		it "should not work for regular user" do 
			@tsukihi.tsundere_for(:user)[:fanservice].should =~ /faggot/i
		end # it
	end # []
	
end # SchoolGirl