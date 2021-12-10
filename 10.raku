my %pairs =  '(' => ')', '[' => ']', '{' => '}',  '<' => '>';
my %cscore = ')' => 3,   ']' => 57,  '}' => 1197, '>' => 25137;
my %iscore = ')' => '1', ']' => '2', '}' => '3',  '>' => '4';

sub check($line) {
	my @s;
	for $line.comb {
		if $_ ∈ %pairs {
			@s.push: %pairs{$_};
		} elsif $_ ne @s.pop {
			return %cscore{$_}, 0;
		}
	}
	return 0, @s.join.flip.trans(%iscore).parse-base(5);
}

my @s = lines».&check;
say @s»[0].sum;
say @s.grep(!*.[0])»[1].sort[*/2];
