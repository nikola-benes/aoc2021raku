my %edges;
for lines».split('-') -> ($a, $b) {
	%edges{$a}.push: $b;
	%edges{$b}.push: $a;
}

sub paths($from, %seen, $allow_twice) {
	state %cache;
	%cache{"$from;{%seen};$allow_twice"} //=
	$from eq 'end' ?? 1 !! sum gather for %edges{$from}<> {
		if $_ ∉ %seen {
			%seen.set: $_ if $_ eq .lc;
			take paths($_, %seen, $allow_twice);
			%seen.unset: $_;
		} elsif $allow_twice && $_ ne 'start' {
			take paths($_, %seen, False);
		}
	}
}

say paths('start', SetHash.new('start'), $_) for False, True;
