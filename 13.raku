sub show(%p) {
	my ($mx, $my) = map *».Int.max + 1, [Z] %p.keys».split(' ');
	for ^$my -> $y {
		for ^$mx -> $x {
			print "$x $y" ∈ %p ?? '██' !! '  ';
		}
		print "\n";
	}
}

sub fold($p, $what, $where) {
	my ($x, $y) = $p.split: ' ';
	with $::($what) {
		$_ = 2 * $where - $_ if $_ > $where;
	}
	"$x $y";
}

my ($xy, $fold) = slurp.split: "\n\n";
my %p = set $xy.split("\n").map: *.comb(/\d+/).Str;

for $fold.split("\n", :skip-empty) {
	my ($what, $where) = m/(<[xy]>) '=' (\d+)/.list».Str;
	%p = set %p.keys.map: { fold $_, $what, $where };
	once say %p.elems;
}

show %p;
