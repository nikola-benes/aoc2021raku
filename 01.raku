my @input = $*IN.lines;

sub solve { say sum @_ Z< @_[1..*] };

solve @input;

solve [Z+] ^3 .map: { @input[$_..*] };
