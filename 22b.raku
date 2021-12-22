sub min-max($a, $b, $which) { $which ?? $a min $b !! $a max $b }

sub bounds(@c, @b, $d) { (^2).map: { min-max @c[$d;$_], @b[$d;$_], $_ } }

sub shift-bound(@b, $d, $i, $new) {
	@b.clone.&{ with .[$d] .= clone { .[$i] = $new }; $_ }
}

my @all = [-Inf, Inf] xx 3;

class Tree {
	has Bool $.light = False;
	has Int $.dim;
	has Int $.split;
	has Tree @.children;

	method leaf(--> Bool) { ! @!children }

	method add-cube(@c, $on, @b = @all) {
		if @!children -> $_ {  # inner node
			my ($lo, $hi) = bounds @c, @b, $!dim;
			for ($lo < $!split, $!split < $hi) Z ^2 -> ($c, $i) {
				.[$i].add-cube: @c, $on,
					shift-bound @b, $!dim, !$i, $!split
						if $c;
			}

			if all(.map: *.leaf) and [==] .map: *.light {
				# join
				$!light = .[0].light;
				@!children = ();
			}

			return
		}

		# leaf
		return if $!light == $on;

		for ^2 X ^3 -> ($i, $dim) {
			my $b = @b[$dim;$i];
			my $s = bounds(@c, @b, $dim)[$i];

			if min-max($s, $b, $i) != $b {
				$!dim = $dim;
				$!split = $s;
				@!children = Tree.new(light => $!light) xx 2;
				@!children[!$i].add-cube: @c, $on,
					shift-bound @b, $dim, $i, $s;
				return
			}
		}

		# this leaf is the cube
		$!light = $on;
	}

	method lights($level = 0, @b = @all) {
		$.leaf
		?? $!light && [×] @b.map: { .[1] - .[0] }
		!! [+] (^2).map: {
			@!children[$_].lights: $level + 1,
				shift-bound @b, $!dim, !$_, $!split
		}
	}
}

my Tree $t .= new;

for (lines) {
	# convert to half-open intervals
	my @c = .comb(/'-'? \d+/)».Int.rotor(2).map: { .[0], .[1] + 1 };

	$t.add-cube: @c, ?m/^on/;
}

say $t.lights;
