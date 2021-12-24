# input observations:
# - for each input digit the following is done:
#   w = input()
#   if (z % 26 + VAR1) == w:
#       z /= DIV_Z
#   else:
#       z = (z / DIV_Z) * 26 + w + VAR2
#
# - DIV_Z is 1 (iff VAR1 > 9) or 26 (iff VAR1 < 0)
# - VAR1 > 9 means that z % 26 + VAR1 != w
# - 0 < VAR2 < 17, so 0 < w + VAR2 < 26
# - thus, z is effectively a stack (z % 26 is top, z / 26 is rest) and
#   the code is:
#   w = input()
#   case DIV_Z == 1:
#      z.push(w + VAR2)
#   case DIV_Z == 26:
#      if z.top + VAR1 == W:
#         z.pop
#      else:
#         z.top = w + VAR2
# - the number of 1's and 26's appearing in DIV_Z is equal,
#   and at each step the number of 1's so far is ≥ the number of 26's so far
# - we need the stack to be empty at the end; we thus need to always pop

my @eq;
my @z;
my $push;
for lines.kv -> $n, $_ {
	my $i = $n % 18;
	my $w = $n div 18;
	if $i == 4 {
		m/'div z ' (1|26)/;
		$push = $0 == 1;
	} elsif $i == 5 && !$push {
		m/'add x ' (\-?\d+)/;
		my ($a, $d) = @z.pop;
		@eq.push: ($a, $d + $0, $w);
	} elsif $i == 15 && $push {
		m/'add y ' (\d+)/;
		@z.push: ($w, $0);
	}
}

my @hi;
my @lo;
for @eq {
	# input[$a] + $d == input[$b]
	my ($a, $d, $b) = $_;
	if $d < 0 {
		($a, $b) = ($b, $a);
		$d = -$d;
	}
	@hi[$a, $b] = 9 - $d, 9;
	@lo[$a, $b] = 1, 1 + $d;
}

.join.say for @hi, @lo;
