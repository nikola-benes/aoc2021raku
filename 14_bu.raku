# bottom-up solution

use experimental :cached;

my @p = get.comb;
get;
my %rules = slurp.comb: /\w+/;

my %prev = %rules.keys.map: * => bag();

for 1 .. 40 {
	my %next;
	for %rules.kv -> $ab, $c {
		my ($a, $b) = $ab.comb;
		%next{$ab} = bag($c) ⊎ %prev{"$a$c"} ⊎ %prev{"$c$b"};
	}

	if $_ == 10 | 40 {
		my %b = [⊎] bag(@p), |@p.rotor(2 => -1).map: { %next{$_.join} }
		say [-] %b.values.sort[*-1, 0];
	}

	%prev = %next;
}
