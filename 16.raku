class CountIter {
	has $!it;
	has $.c;

	method bits($n) {
		$!c += $n;
		do for ^$n { $!it.pull-one }
	}

	method new($seq) { self.bless(it => $seq.iterator); }
	submethod BUILD(:$!it, :$!c = 0) {}
}

sub I {	@_.join.parse-base(2) }

sub decode($it) {
	my $v = I $it.bits: 3;
	my $t = I $it.bits: 3;

	if $t == 4 {
		return $v, I do repeat while $_ {
			$_ = I $it.bits: 1;
			$it.bits: 4;
		}
	}

	my @p;

	if I $it.bits: 1 {
		@p = do for ^I $it.bits: 11 { decode($it) };
	} else {
		my $len = I $it.bits: 15;
		my $stop = $it.c + $len;
		@p = do while $it.c < $stop { decode($it) };
	}

	$v += [+] @p»[0];
	my @args = @p»[1];

	$v, do given $t {
		when 0 { [+] @args }
		when 1 { [×] @args }
		when 2 { min @args }
		when 3 { max @args }
		when 5 { [>] @args }
		when 6 { [<] @args }
		when 7 { [==] @args }
	}
}

decode(CountIter.new: get.comb.map(*.parse-base(16).fmt("%04b").comb).flat)
	.join("\n").say;
