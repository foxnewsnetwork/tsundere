require 'spec_helper'

class Person
	def self.ranks
		[:stranger, :classmate, :senpai, :osanajimi, :oniichan, :trevor]
	end # ranks
	attr_accessor :level, :rank
	@@ranks = {
		:stranger => 1,
		:classmate => 2,
		:senpai => 3,
		:osanajimi => 4,
		:oniichan => 5,
		:trevor => 6
	}
	def initialize rank
		@level = @@ranks[rank]
		@rank = rank
	end # initialize
end # Person

class HighSchooler
	def self.actions
		[:speak_with, :eat_with, :go_on_date_with, :hold_hands_with, :bathe_with, :pomf_on_bed_with]
	end # actions
	include Tsundere
	attr_tsundere :speak_with, :fail => "damare!", :as => { :stranger => 1 }
	attr_tsundere :eat_with, :fail => "itadakimasu!", :as => { :classmate => 2 }
	attr_tsundere :go_on_date_with, :fail => "furareta", :as => { :senpai => 3 }
	attr_tsundere :hold_hands_with, :fail => "kyaa!", :as => { :osanajimi => 4 }
	attr_tsundere :bathe_with, :fail => "oniichan no ecchi!", :as => { :oniichan => 5 }
	attr_tsundere :pomf_on_bed_with, :as => { :trevor => 6 }
	
	def initialize unused

	end 

	def speak_with
		true
	end # speak
	def eat_with
		true
	end #  eat
	def go_on_date_with
		true
	end #  go_on_date
	def hold_hands_with
		true
	end #  hold_hands
	def bathe_with
		true
	end #  bathe
	def pomf_on_bed_with
		true
	end #  pomf_on_bed
end # SchoolGirl

describe "HighSchooler-Person relationships" do 
	context "passing in user" do 
		before :each do 
			@oniichan = Person.new :oniichan
			@dekomori = HighSchooler.new :death
		end # each

		it "should permit oniichan to bathe with dekomori" do 
			@dekomori.tsundere_for(@oniichan).bathe_with.should be_true
		end # it
		it "should not let oniichan pomf" do 
			@dekomori.tsundere_for(@oniichan).pomf_on_bed_with.should =~ /ecchi/i
		end # it
	end # context
end # relationships