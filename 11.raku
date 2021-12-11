my @d = (-1..1 X -1..1).grep: * ne (0, 0);
my @map = lines.map: { [.comb».Int] };
my $size = (@map.elems, @map[0].elems);

sub valid($p)      { all(0 «≤» $p) && all($p «<» $size) }
sub neighbours($p) { @d.map($p «+» *).grep(&valid) }
sub tile(($y, $x)) { return-rw @map[$y;$x] }

sub step {
	my @q;
	my %s is SetHash;

	sub inc($p) {
		if "$p" ∉ %s && ++tile($p) > 9 {
			@q.push: $p;
			%s.set: "$p";
			tile($p) = 0;
		}
	}

	inc($_) for [X] ^«$size;
	while @q {
		inc($_) for neighbours @q.shift;
	}
	%s.elems;
}

say do for ^100 { step }.sum;

my $c = [×] $size<>;
my $i = 101;
while (step) != $c { ++$i }
say $i;
