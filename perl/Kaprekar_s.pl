#!/usr/bin/env perl

use strict;
use warnings;
use v5.22;
use Time::HiRes qw(gettimeofday);
my $start_time = Time::HiRes::time;  

my ($cnt,$numnum,$num1,$num2,$ans_arr);
my (@arr,@buf1,@buf2);

foreach (1..10){
foreach $cnt (0..99){
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
