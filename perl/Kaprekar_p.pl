#!/usr/bin/env perl

use strict;
use warnings;
use Parallel::ForkManager;
use Data::Dumper;
use Time::HiRes qw(gettimeofday);
my $start_time = Time::HiRes::time;

my ($cnt,$numnum,$num1,$num2,$ans_arr);

my $ref = [
    [],
    [],
    [],
    []
];

for $cnt (0..99) {
    push @{$ref->[$cnt % 4]}, $cnt; 
}

#$ref[[0,4..][1,5..][2,6..][3,7..]]

foreach (1..10){

my $pm = new Parallel::ForkManager(4);

foreach (@$ref){
 my $pid = $pm->start and next;
 	#print Dumper @$_;
	&Kaprekar(@$_);
 
 $pm->finish;
}
$pm->wait_all_children;


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

}


printf("time = "."%0.3f\n",Time::HiRes::time - $start_time);  
