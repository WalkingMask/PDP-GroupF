#!/usr/bin/env perl

use strict;
use warnings;
use Parallel::ForkManager;
use Data::Dumper;
use Time::HiRes qw(gettimeofday);

#$B;~4V7WB,(B
my $start_time = Time::HiRes::time;
#$BJQ?t@k8@(B
my ($cnt,$numnum,$num1,$num2,$ans_arr);
#$B%j%U%!%l%s%9@8@.(B
my $ref = [
    [],
    [],
    [],
    []
];
#$BG[Ns%j%U%!%l%s%9$r(B4$BJ,3d(B[1,5..][2,6..][3,7..][4,8..]
for $cnt (0..999999) {
    push @{$ref->[$cnt % 4]}, $cnt; 
}

#$B<B:]$KCf?H$O$3$&$J$k"-(B
#$ref[[0,4..][1,5..][2,6..][3,7..]]
#$B<h$j=P$9:]$O$G%j%U%!%l%s%9(B_@$ref 

#$B:GBg(B4$B%W%m%;%9$G%+%W%l%+?t$r;;=P(B
my $pm = new Parallel::ForkManager(4);

#10$B2s7WB,$J$N$GC1=c$K(Bforeach$B$G(B10$B2s2s$7$F$$$k(B
foreach (1..10){

foreach (@$ref){
 my $pid = $pm->start and next; #$B%W%m%;%9$r(Bfork
 	#print Dumper @$_; Debug : $B%j%U%!%l%s%9$NCf?H3NG'(B
	&Kaprekar(@$_);
 
 $pm->finish; #$B;R%W%m%;%9$r=*N;(B
}
$pm->wait_all_children;

}

sub Kaprekar {
my (@arr,@buf1,@buf2);
foreach $cnt (@_){
	@arr = split (//,$cnt);

	@buf1 = sort {$b <=> $a} @arr;
	@buf2 = sort {$a <=> $b} @arr;
	
	$num1 = join('', @buf1);
	$num2 = join('', @buf2);
	$ans_arr = join('', @arr);
	
	$numnum = $num1 - $num2;

	if ($numnum == $ans_arr){
		print "$ans_arr\n";
	}
}

}

printf("time = "."%0.3f\n",Time::HiRes::time - $start_time);  
