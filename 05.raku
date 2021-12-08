my %floor;

for (lines) {
	my ($x1, $y1, $x2, $y2) = .comb(/\d+/)».Int;
	my $s = (($x1 ... $x2), ($y1 ... $y2));

	for $x1 == $x2 || $y1 == $y2 ?? ((1, 2) X [X] $s) !! (2 X [Z] $s)
	-> ($p, $_) {
		++%floor{$p}{$_};
	}
}

say %floor{1, 2}».grep(*.value > 1)».elems.join: "\n";
