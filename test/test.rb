#!ruby
require "lib/gol"
require "test/unit"

class TestAdd < Test::Unit::TestCase
	def test_simple
		assert_equal(3, Add.new(1,2).result)
	end
	# def test_simple2
	# 	assert_equal(2, Add.new(1,2).result)
	# end		
end
