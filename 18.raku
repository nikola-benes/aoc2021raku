grammar SNum {
	token TOP { '[' <elem> ',' <elem> ']' }
	token elem { \d | <TOP> }
}

class SNumActions {
	method TOP($/) { make [ $<elem>».made ] }
	method elem($/) { make $<TOP>.made // $/.Int }
}

sub explode($tree, $level = 1) {
	for 0, 1 -> $i {
		my $node := $tree[$i];
		next if $node ~~ Int;

		my ($act, $ret);

		if $level == 4 {
			$act = add => (!$i, $node[!$i]);
			$ret = add => ($i, $node[$i]);
			$node = 0;
		} else {
			$act = explode $node, $level + 1;
		}

		with $act<changed> {
			return :changed if $_;
			next;
		}

		my ($j, $val) = $act<add>;
		if $j == $i {
			return $level == 1 ?? :changed !! $act;
		}

		$node := $tree[$j];
		while $node !~~ Int {
			$node := $node[!$j];
		}
		$node += $val;
		return $ret // :changed;
	}

	return :!changed;
}

sub split($tree) {
	for $tree<> <-> $_ {
		when Array {
			return True if split $_;
		}
		when * >= 10 {
			my $d = $_ / 2;
			$_ = [ $d.floor, $d.ceiling ];
			return True;
		}
	}
	return False;
}

sub infix:<T+>($t1, $t2) {
	my $tree = [$t1, $t2];
	loop {
		next if explode($tree)<changed>;
		last unless split $tree;
	}
	$tree
}

sub magnitude($tree) {
	$tree ~~ Int
		?? $tree
		!! 3 * magnitude($tree[0]) + 2 * magnitude($tree[1])
}

sub deepcopy(@a) { @a.deepmap: { my $ = $_ } }

my @trees = lines.map: { SNum.parse($_, actions => SNumActions).made };

say magnitude [T+] deepcopy @trees;

say max do for @trees X @trees {
	next if $_[0] === $_[1];
	magnitude [T+] .map: &deepcopy;
};
