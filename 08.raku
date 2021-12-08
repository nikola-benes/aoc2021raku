# behold! frequency analysis to the rescue!

my @s = <abcefg cf acdeg acdfg bcdf abdfg abdefg acf abcdefg abcdfg>;

sub signature {
	my %freq;

	for @_ {
		my $c = .chars;
		++%freq{$_}{$c} for .comb;
	}

	%freq.map({
		.key => .value.sort».kv.flat.join(':');
	}).Map;
}

my %num = @s.antipairs;
my %sig_to_wire = signature(@s).antipairs;

my ($p1, $p2) X= 0;

for (lines) {
	my (@p, @d) Z= .split('|')».comb(/\w+/);

	$p1 += @d.grep(*.chars != 5 | 6).elems;

	my %t = signature(@p).map: { .key => %sig_to_wire{.value} };
	$p2 += @d.map({ %num{ .trans(%t).comb.sort.join } }).join;

}

.say for $p1, $p2;
