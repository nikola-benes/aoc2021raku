use Algorithm::Heap::Binary;

my @d = (0, 1), (0, -1), (1, 0), (-1, 0);

sub solve(@map) {
	my $size = (@map.elems, @map[0].elems);
	my $src = (0, 0);
	my $dst = ($size<> X- 1).list;

	sub valid($p)      { all(0 «≤» $p) && all($p «<» $size) }
	sub neighbours($p) { @d.map($p «+» *).grep(&valid) }
	sub tile(($y, $x)) { @map[$y;$x] }

	my Algorithm::Heap::Binary $heap .= new;
	$heap.push(0 => $src);
	my %dist = "$src" => 0;
	my %done is SetHash;

	while not $heap.is-empty {
		my ($v, $p) = $heap.pop.kv;
		next if "$p" ∈ %done;
		%done.set: "$p";

		if $p eq $dst {
			return $v;
		}

		for neighbours $p {
			my $pv = $v + tile($_);
			if $_ ∉ %dist || %dist{"$_"} > $pv {
				%dist{"$_"} = $pv;
				$heap.push: $pv => $_;
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
