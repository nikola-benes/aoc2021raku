my @input = get.comb(/\d+/)».Int;

# median minimises the sum of absolute deviations

say (@input X- @input.sort[* / 2])».abs.sum;

my $avg = @input.sum / @input;

# it can be shown that the optimum lies in the open interval (avg - 1, avg + 1)

say do for ($avg.floor .. $avg.ceiling) {
	(@input X- $_)».abs.map({ $_ * ($_ + 1) / 2 }).sum;

}.min;
