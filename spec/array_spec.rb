require 'spec_helper'
#require 'debugger'
describe Array do 
	describe "binary search raw" do
		before :each do
			@array = [0,1,2,3,4,5,6,7,8,9]
		end # each
		10.times do |n|
			it "should have decent coverage #{n}" do
				@array.binary_search_raw(n).should eq n
			end # it
			it "should have decent coverage #{n} lean left" do
				@array.binary_search_raw(n, :left => true).should eq n
			end # it
			it "should, given #{n-0.5}, get index #{n}" do
				# debugger
				@array.binary_search_raw(n - 0.5).should eq n
			end # it
			it "should, given #{n+0.5}, get index #{n}, with left preference" do
				# debugger
				@array.binary_search_raw(n + 0.5, :left => true).should eq n
			end # it
		end # each n

		it "should handle the empty array" do
			[].binary_search_raw(4).should eq 0
		end # it
		it "should handle odd input" do
			@array.binary_search_raw(-1).should eq 0
		end # it
		it "should handle odd input on the big end " do
			@array.binary_search_raw(11).should eq 10
		end # it

		it "should handle the empty array left" do
			[].binary_search_raw(4, :left => true).should eq 0
		end # it
		it "should handle odd input left" do
			@array.binary_search_raw(-1, :left => true).should eq 0
		end # it
		it "should handle odd input on the big end left" do
			@array.binary_search_raw(11, :left => true).should eq 9
		end # it
	end # bsr

	describe "construction" do 
		it "should construct an ordered array" do 
			@array = []
			10.times do
				val = rand(100)
				ind = @array.binary_search_raw(val)
				@array.insert(ind, val)
			end # 10 times
			
			@array.count.should eq 10
			@array.should eq @array.sort
		end # it
	end # construction
end # Array