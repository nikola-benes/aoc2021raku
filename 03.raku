sub prefix:<I> { Int("0b" ~ [~] @_».Int) };

my @input = lines.map: *.comb.list;

my @r = ([Z+] $_) X≥ .elems / 2 with @input;

say I@r × I!«@r;

say [×] do for ^2 -> $n {
	my @s = @input;
	loop (my $p = 0; @s.elems > 1; ++$p) {
		my $m = @s»[$p].sum ≥ @s.elems / 2;
		@s .= grep: *[$p] == $m ?^ $n;
	}
	I@s[0];
}
