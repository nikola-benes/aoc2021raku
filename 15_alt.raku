use Algorithm::Heap::Binary;

my @d = (0, 1), (0, -1), (1, 0), (-1, 0);

sub solve(@map) {
	my $size = (@map.elems, @map[0].elems);
	my $src = (0, 0);
	my $dst = ($size<> X- 1).list;

	my Algorithm::Heap::Binary $heap .= new;
	$heap.push(0 => $src);
	my %dist = "$src" => 0;
	my %done is SetHash;

	while not $heap.is-empty {
		my ($v, $p) = $heap.pop.kv;
		next if %done{"p"};
		%done.set: "$p";

		if $p eq $dst {
			return $v;
		}

		for @d -> ($dx, $dy) {
			my $nx = $p[0] + $dx;
			my $ny = $p[1] + $dy;
			next unless 0 ≤ $ny < $size[0] && 0 ≤ $nx < $size[1];

			my $n = ($nx, $ny);
			my $pv = $v + @map[$ny][$nx];
			if %dist{"$n"}:!exists || %dist{"$n"} > $pv {
				%dist{"$n"} = $pv;
				$heap.push: $pv => $n;
			}
		}
	}
}

my @map = lines.map: *.comb».Int.list;
say solve @map;

my @big;
for ^5 -> $a {
	for @map {
		@big.push: (^5 X+ @$_).map: (* + $a - 1) % 9 + 1;
	}
}
say solve @big;
