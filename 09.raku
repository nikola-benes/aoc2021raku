my @d = (0, 1), (0, -1), (1, 0), (-1, 0);
my @map = lines.map: *.comb».Int.list;
my $size = (@map.elems, @map[0].elems);

sub valid($p)      { all(0 «≤» $p) && all($p «<» $size) }
sub neighbours($p) { @d.map($p «+» *).grep(&valid) }
sub tile(($y, $x)) { @map[$y;$x] }

my @lows = gather for [X] ^«$size -> $p {
	my $t = tile($p);
	if neighbours($p).map({ $t ≥ tile($_) }).none {
		take $p;
	}
}

say @lows.map({ tile($_) + 1 }).sum;

say [×] gather for @lows {
	my @q = $_;
	my %s is SetHash;
	%s.set: "$_";
	while @q {
		my $p = @q.shift;
		my $t = tile($p);
		for neighbours($p) {
			if $t < tile($_) < 9 && "$_" ∉ %s {
				@q.push: $_;
				%s.set: "$_";
			}
		}
	}
	take %s.elems;
}.sort.tail(3);
