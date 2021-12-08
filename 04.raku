my @nums = get.split: ',';

my @bingo = do for slurp.split: "\n\n" {
	my @m = .split("\n", :skip-empty).map: *.comb(/\d+/).list;
	|@m.List, |[Z] @m;
}

my %seen is SetHash;

my $w = gather for @nums -> $n {
	%seen.set: $n;
	for @bingo.grep(*.any ⊆ %seen):kv -> $k, $_ {
		take (.flat ∖ %seen).keys.sum × $n;
		@bingo[$k]:delete;
	}
}

say $w[$_] for 0, *-1;
