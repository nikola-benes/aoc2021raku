use Algorithm::Heap::Binary;

my @nl is List = <A B C D>;
my %ln is Map = @nl.antipairs;
my $size;

class State {
	has @.hall;
	has @.rooms;

	method WHICH {
		ValueObjAt.new: "State|{@.hall}|{@.rooms.join: '|'}"
	}

	method clone {
		nextwith hall => @!hall.clone, rooms => @!rooms.map: *.clone
	}
}

sub succs(State $s is copy) {
	# get out
	for $s.rooms.kv -> $i, $r {
		next if $r.all eq @nl[$i];

		my $a := $r.pop;
		my $p := 2 * ($i + 1);
		my $steps := $size - $r.elems;
		for ($p - 1 ... 0), ($p + 1 ... 10) { for $_ {
			last unless $s.hall[$_] eq '.';
			next if $_ ∈ (2, 4, 6, 8);
			my $n = $s.clone;
			$n.hall[$_] = $a;
			take $n, 10 ** %ln{$a} * ($steps + abs $p - $_);
		} }

		$r.push: $a;
	}

	# get in
	for $s.rooms.kv -> $i, $r {
		next if $r.elems == $size or $r.all ne @nl[$i];

		my $a := @nl[$i];
		my $p := 2 * ($i + 1);
		my $steps := $size - $r.elems;
		for ($p - 1 ... 0), ($p + 1 ... 10) { for $_ {
			next if $s.hall[$_] eq '.';
			last unless $s.hall[$_] eq $a;
			my $n = $s.clone;
			$n.rooms[$i].push: $a;
			$n.hall[$_] = '.';
			take $n, 10 ** %ln{$a} * ($steps + abs $p - $_);
			last;
		} }
	}
}

get;
my State $init .= new:
	hall => get.comb('.'),
	rooms => ([Z] lines[0 .. * - 2].reverse».comb: /\w/)».Array;

$size = $init.rooms[0].elems;

my State $goal .= new:
	hall => '.' xx 11,
	rooms => @nl.map: { [$_ xx $size] };

my Algorithm::Heap::Binary $heap .= new;
my %dist{State};
my %done is SetHash;

$heap.push: 0 => $init;
%dist{$init} = 0;

while not $heap.is-empty {
	my ($e, $s) = $heap.pop.kv;
	next if $s ∈ %done;
	%done.set: $s;

	if $s === $goal {
		say $e;
		exit;
	}

	for gather succs $s -> ($n, $d) {
		my $ne = $e + $d;
		if $n ∉ %dist || %dist{$n} > $ne {
			%dist{$n} = $ne;
			$heap.push: $ne => $n;
		}
	}
}
