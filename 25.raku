my @init = lines.map: *.comb.Array;
my ($h, $w) = @init.elems, @init[0].elems;

sub step(@s) {
	my @state := @s;
	my @next = ['.' xx $w] xx $h;
	for ^$h X ^$w -> ($y, $x) {
		if @state[$y;$x] eq '>' {
			if @state[$y; ($x + 1) % $w] eq '.' {
				@next[$y; ($x + 1) % $w] = '>'
			} else {
				@next[$y;$x] = '>'
			}
		} elsif @state[$y;$x] eq 'v' {
			@next[$y;$x] = 'v'
		}
	}

	@state := @next.clone;
	@next = ['.' xx $w] xx $h;

	for ^$h X ^$w -> ($y, $x) {
		if @state[$y;$x] eq 'v' {
			if @state[($y + 1) % $h; $x] eq '.' {
				@next[($y + 1) % $h; $x] = 'v'
			} else {
				@next[$y;$x] = 'v'
			}
		} elsif @state[$y;$x] eq '>' {
			@next[$y;$x] = '>'
		}
	}
	@next;
}

my @state := @init;

for ^Inf {
	my @next = step @state;
	if @next eq @state {
		say $_ + 1;
		last;
	}
	@state := @next;
}
