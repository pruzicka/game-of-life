require 'lib/gol'

t = 0
to = 20
f = Field.new(16,16)


while t < to
	# system ("clear")

	print "Time is #{t}\n"
	f.print_grid

	f.evolve

	f.age_cells

	sleep 2
	t += 1
end
print "Time is #{t}\n"
f.print_grid