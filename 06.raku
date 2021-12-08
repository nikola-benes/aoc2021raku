my $days = 256;

my @count = 0 xx 9;
++@count[$_] for lines.comb: /\d/;

for ^$days {
	@count = @count.rotate Z+ (|(0 xx 6), @count[0], 0, 0);
	say @count.sum if $_ == 79;
}

say @count.sum;
