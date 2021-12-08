my %dir = forward => 1i, down => 1, up => -1;
my ($p1, $p2) X= 0i;

for (words) -> $d, $s {
	my $step = %dir{$d} * $s;
	$p1 += $step;
	$p2 += $step + $s * $p1.re if $d eq 'forward';
}

say .re * .im for $p1, $p2;
