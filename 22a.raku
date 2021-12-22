my %lights is SetHash;

for (lines) {
	my $s = ?m/^on/;
	my @c = .comb(/'-'? \d+/)».Int.rotor(2).map:
		{ (-50 max .[0]) .. (50 min .[1]) };
	for [X] @c {
		%lights{~$_} = $s;
	}
}

say %lights.elems;
