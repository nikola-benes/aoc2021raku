sub rot(@point, (@p, @s)) { @point[@p] Z× @s }

sub try_match(@fixed, @scan) {
	state @rs = do {
		my @sp = (1, 1, 1), (-1, -1, 1), (-1, 1, -1), (1, -1, -1);
		my @sn = -«@sp;
		gather for permutations 3 {
			for (.[0] + 1) % 3 == .[1] ?? @sp !! @sn -> @s {
				take [$_, @s];
			}
		}
	}

	my %f_set := @fixed.map(*.Str).Set;

	for @rs -> @r {
		my $offs := do for @fixed X @scan -> (@f, @p) {
			Str(@f Z- rot(@p, @r));
		}.Bag.grep(*.value ≥ 12)».key;

		for $offs<> {
			my @off = .split: ' ';
			my $c = 0;
			for @scan.map: { Str(rot($_, @r) Z+ @off) } {
				if $_ ∈ %f_set and ++$c ≥ 12 {
					@scan .= map: { [rot($_, @r) Z+ @off] };
					return @off;
				}
			}
		}
	}

	return Nil;
}

my @scan;

for (lines) {
	if /'---'/ {
		@scan.push: [];
	} elsif $_ {
		@scan.tail.push: [ .split(',')».Int ];
	}
}


my %todo := SetHash.new: 1 .. @scan.end;
my @bag = 0;
my %fix = 0 => (0, 0, 0);

while %todo {
	my $s := @scan[@bag.pop];
	for %todo.keys.list {
		if try_match($s, @scan[$_]) -> @off {
			@bag.push: $_;
			%todo.unset: $_;
			%fix{$_} = @off;
		}
	}
}

say @scan[*;*].map(*.Str).Set.elems;

say combinations(%fix.values, 2).map({ ([Z-] $_).map(&abs).sum }).max;
