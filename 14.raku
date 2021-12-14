use experimental :cached;

my $start = get;
get;
my %rules = slurp.comb: /\w+/;

sub inner_poly(($a, $b), $n) is cached {
	$n == 0
	?? bag()
	!! do with %rules{"$a$b"} {
	        inner_poly(($a, $_), $n - 1) ⊎
		inner_poly(($_, $b), $n - 1) ⊎
		bag($_);
	}
}

sub poly($p, $n) {
	my @p = $p.comb;
	[⊎] bag(@p), |@p.rotor(2 => -1).map: { inner_poly($_, $n) }
}

for 10, 40 {
	say [-] poly($start, $_).values.sort[*-1, 0];
}
