require 'spec_helper'

class Foobar
	include Tsundere
	attr_looker :admin_only, :as => :admin
	attr_looker :user_and_above, :as => { :user => 4 }
	attr_looker :level4, :as => 4

	def admin_only
		5
	end # admin_only

	def user_and_above
		6
	end

	def level4
		7
	end 
end # Foobar

describe Foobar do 
	describe "Included functionality" do 
		it "should have the permission table" do 
			Foobar.permission_table.should_not be_nil
		end # it
		it "should have the rank table" do 
			Foobar.rank_table.should_not be_nil
		end # it
		it "should have the user entry in the rank table" do 
			Foobar.rank_table[:user].should eq 4
		end # it
	end # included
end # foobar