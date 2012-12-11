## ~tsun tsun

Provides an interface to allow objects to behave differently based upon who is accessing them.
Objects implementing the tsundere class exposes a tsundere_for method that creates a proxy
which filters out unwanted access smoothly.

Suppose you have the following: 

```ruby
# Object
class SchoolGirl
	def speak_with words
		...
	end

	def watch_movie_with person
		...
	end 

	def bathe_with person
		...
	end 

	def be_naughty_with person, &block
		yield person, &block
		...
	end

	def ignore
		...
	end
end

...

# Usage
rikka = SchoolGirl.new :chuu2
if person.is_a? Friend
	rikka.speak_with person.words
else
	rikka.ignore person
end
if person.is_a? Friend and person.is_a? Neighbor and person.name =~ /dark flame master/i
	rikka.speak_with person.words
	rikka.bathe_with person
	...
end
```
The annoying thing is that you need to constantly check for access levels,
which makes your code a mess and becomes easily broken with new updates.
The tsundere interface provides an access level interface to make thing easier:

```ruby
# Object
class SchoolGirl
	include Tsundere
	attr_tsundere :speak_with, :as => { :stranger => 1 }
	attr_tsundere :watch_movie_with, :as => { :friend => 2 }
	attr_tsundere :bathe_with, be_naughty_with :as => { :dark_flame_master => 3 }
	def speak_with words
		...
	end

	def watch_movie_with person
		...
	end 

	def bathe_with person
		...
	end 

	def be_naughty_with person, &block
		yield person, &block
		...
	end

	def ignore
		...
	end
end

...

# Usage
rikka = SchoolGirl.new :chuu2
# if person is a friend, these method will work, if not, this method returns
# a string saying "sorry, this doesn't work"
rikka.tsundere_for(person).speak_with person.words
rikka.tsundere_for(person).watch_movie_with person, 
...
```
Install
=
```
gem install tsundere
```

Usage
=
1. step 1: include the tsundere module into your class
```ruby
class Something
	include Tsundere
	...
```

2. step 2: declare what methods you'd like to be accessible in one of 3 ways:
```ruby
class Something
	include Tsundere
	attr_tsundere :some_method, :another_method, :as => :admin
	attr_tsundere :fourth_method, :as => :management
```
admins can access some_method and another_method
management can access fourth_method

--
```ruby
class Something
	include Tsundere
	attr_tsundere :some_method, :another_method, :third_method, :as => {:admin => 5}
	attr_tsundere :fourth_method, :as => {:super_admin => 6}
```
declared this way, and super_admin can not only access fourth_method, but also all
the methods the regular admin can access

--
```ruby
class Something
	include Tsundere
	attr_tsundere :some_method, :another_method, :third_method, :as => 5
	attr_tsundere :fourth_method, :as => 6
```
this is the same as the previous version, except no names are specified,
but tsundere_for(6) can access fourth_method as well as all the methods
that tsundere_for(5) can access

Notes
=
```ruby
tsundere_for(duck)
```
tsundere_for will work as long as duck is either a string, fixnum, symbol, integer, or float.
Alternatively, if duck exposes a rank or level method that results in a fixnum, string, symbol, float, etc.,
this method will still work.
If duck is a hash, it must expose the :rank or :level key in order to work
If duck is nil, no methods are exposed.

If you don't want to bother with access levels at some point in your application,
simple call your original object without tsundere_for 

Contributing to tsundere
= 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

Copyright
=
Copyright (c) 2012 Thomas Chen. See LICENSE.txt for
further details.

