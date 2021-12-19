sub pos($v, $n) { $n * (2 * $v + 1 - $n) / 2 }

get() ~~ /'x=' (.*) '..' (.*) ', y=' (.*) '..' (.*)/;
my ($xl, $xh, $yl, $yh) = @$/;

my $vxl = ceiling -1 + sqrt(1 + 8 * $xl) / 2;

my $best_vy = 0;
my $count = 0;

for $vxl .. $xh -> $vx {
	for $yl .. -$yl - 1 -> $vy {
		for max(1, 2 * $vy + 2) .. * -> $n {  # first n with y < 0
			my $x = pos $vx, $n min $vx;
			my $y = pos $vy, $n;
			last if $x > $xh or $y < $yl; # overshot
			if $x >= $xl and $y <= $yh {
				# hit
				++$count;
				$best_vy max= $vy;
				last;
			}
		}
	}
}

say pos $best_vy, $best_vy;
say $count;
