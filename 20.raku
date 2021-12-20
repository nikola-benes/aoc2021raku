my Bool @rules = get.comb.map: * eq '#';

class Image {
	has %.pixels is Set;
	has ($.xl, $.xh, $.yl, $.yh);
	has $.border = False;

	method inside($x, $y) { $!xl ≤ $x ≤ $!xh && $!yl ≤ $y ≤ $!yh }
	method get($x, $y) {
		self.inside($x, $y) ?? %!pixels{"$x,$y"} !! $!border
	}

	method neigh($x, $y) {
		my $r = 0;
		for $y - 1 .. $y + 1 X $x - 1 .. $x + 1 -> ($y, $x) {
			$r = $r * 2 + self.get($x, $y);
		}
		$r;
	}

	method step() {
		my ($xl, $xh, $yl, $yh);
		%!pixels := gather
		for $!xl - 1 .. $!xh + 1 X $!yl - 1 .. $!yh + 1 -> ($x, $y) {
			if @rules[self.neigh($x, $y)] {
				$xl min= $x;
				$xh max= $x;
				$yl min= $y;
				$yh max= $y;
				take "$x,$y";
			}
		}.Set;
		$!border = @rules[$!border * 511];
		($!yl, $!yh, $!xl, $!xh) Z= ($yl, $yh, $xl, $xh);
	}

	method load() {
		$!xl = $!yl = 0;
		%!pixels := gather for words.kv -> $y, $_ {
			$!yh max= $y;
			for .comb.kv -> $x, $_ {
				$!xh max= $x;
				take "$x,$y" if $_ eq '#';
			}
		}.Set;
	}
}

my Image $image .= new;
$image.load();

for 2, 48 {
	$image.step for ^$_;
	say $image.pixels.elems;
}
