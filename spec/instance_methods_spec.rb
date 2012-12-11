require 'spec_helper'

class StereotypicalLoli
	include Tsundere
	attr_looker :allow_stranger, :as => { :stranger => 1 }
	attr_looker :allow_shiriai, :as => { :shiriai => 2 }
	attr_looker :allow_tomodachi, :as => { :tomodachi => 3 }
	attr_looker :allow_osanajimi, :as => { :osanajimi => 4 }
	attr_looker :allow_senpai, :as => { :senpai => 5 }
	attr_looker :allow_oneechan, :as => { :oneechan => 6 }
	attr_looker :allow_oniichan, :as => { :oniichan => 7 }

	def allow_oniichan
		7
	end 

	def allow_oneechan
		6
	end 

	def allow_senpai
		5
	end

	def allow_osanajimi
		4
	end  

	def allow_tomodachi
		3
	end  

	def allow_shiriai
		2
	end

	def allow_stranger
		1
	end 
end # StereotypicalLoli
describe StereotypicalLoli do
	describe "access" do 
		before :each do 
			@loli = StereotypicalLoli.new
		end # each
		it "should allow oniichan to do everything" do 
			@loli.tsundere_for(:oniichan).allow_oniichan.should eq 7
			@loli.tsundere_for(:oniichan).allow_oneechan.should eq 6
			@loli.tsundere_for(:oniichan).allow_senpai.should eq 5
			@loli.tsundere_for(:oniichan).allow_osanajimi.should eq 4
			@loli.tsundere_for(:oniichan).allow_tomodachi.should eq 3
			@loli.tsundere_for(:oniichan).allow_shiriai.should eq 2
			@loli.tsundere_for(:oniichan).allow_stranger.should eq 1
		end # it
		it "should not allow a regular friend to touch where only oniichan can touch" do 
			@loli.tsundere_for(:tomodachi).allow_oniichan.should =~ /sorry/i
			@loli.tsundere_for(:tomodachi).allow_oneechan.should =~ /sorry/i
			@loli.tsundere_for(:tomodachi).allow_senpai.should =~ /sorry/i
			@loli.tsundere_for(:tomodachi).allow_osanajimi.should =~ /sorry/i
		end # it
		it "should allow a regular friend to do friendzone stuff" do 
			@loli.tsundere_for(:tomodachi).allow_tomodachi.should eq 3
			@loli.tsundere_for(:tomodachi).allow_shiriai.should eq 2
			@loli.tsundere_for(:tomodachi).allow_stranger.should eq 1
		end # it
		it "should not allow a friend to get out of the friend zone" do 
			@loli.tsundere_for(:tomodachi).allow_oniichan.should =~ /sorry/i
		end # it
	end # access
end # Footbar