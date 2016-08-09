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
#$B:G8e$N%W%m%;%9$rBT$D0Y$K2<5-$N%3!<%I$,I,MW(B
$pm->wait_all_children;

}

#$B%+%W%l%+?t$r;;=P$9$k4X?t$rDj5A(B
sub Kaprekar {
my (@arr,@buf1,@buf2);

#$BM?$($i$l$?G[NsJ,(Bforeach$B$G2s$7$F$$$k(B
foreach $cnt (@_){
	#$BEO$5$l$?G[Ns$NMWAG$r(B1$B7e$:$DG[Ns$KBeF~(B
	@arr = split (//,$cnt);
	
	#@arr$B$NCf?H$r>:=g$K(Bsort
	@buf1 = sort {$b <=> $a} @arr;
	#@arr$B$NCf?H$r9_=g$K(Bsort
	@buf2 = sort {$a <=> $b} @arr;
	
	#sort$B$7$?(B@arr$B$NG[NsMWAG$r(Bjoin$B$7?tCM$H$7$F;2>H(B
	$num1 = join('', @buf1);
	$num2 = join('', @buf2);
	#$BEO$5$l$?(B@arr$B$NMWAG$r(Bjoin$B$7?tCM$H$7$F;2>H(B
	$ans_arr = join('', @arr);
	
	#$B%+%W%l%+?tH=Dj(B
	$numnum = $num1 - $num2;

	if ($numnum == $ans_arr){
		print "$ans_arr\n";
	}
}

}

printf("time = "."%0.3f\n",Time::HiRes::time - $start_time);  
