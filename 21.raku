my @start = slurp.comb(/\d+/)[1, 3];

sub advance($p is rw, $d) { $p = ($p + $d) % 10 || 10 }

# part 1

my $p = 1;
my @pos = @start;
my @score = [0, 0];

loop (my $r = 0; @score[$p] < 1000; ++$r) {
	$p = !$p;
	@score[$p] += advance @pos[$p], 6 - $r;
}

say @score[!$p] * 3 * $r;

# part 2

my %throws is Bag = (1..3 X 1..3 X 1..3)».sum;
my %state is BagHash;
%state.add: ~(@start, 0, 0);

my @wins = [0, 0];
$p = 1;

while %state {
	$p = !$p;
	my %new is BagHash;
	for %state.kv -> $state, $sc {
		for %throws.kv -> $d, $dc {
			my (@pos, @score) Z= $state.split(' ').rotor(2);
			if (@score[$p] += advance @pos[$p], $d) >= 21 {
				@wins[$p] += $dc * $sc;
			} else {
				%new{~(@pos, @score)} += $dc * $sc;
			}
		}
	}
	%state := %new;
}

say max @wins;
