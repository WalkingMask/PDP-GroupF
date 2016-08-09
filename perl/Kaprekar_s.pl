#!/usr/bin/env perl

use strict;
use warnings;
use Time::HiRes qw(gettimeofday);

#時間計測
my $start_time = Time::HiRes::time;
#変数宣言
my ($cnt,$numnum,$num1,$num2,$ans_arr);
#リファレンス生成
my $ref = [
    [],
    [],
    [],
    []
];
#配列リファレンスを4分割[1,5..][2,6..][3,7..][4,8..]
for $cnt (0..9999) {
    push @{$ref->[$cnt % 4]}, $cnt; 
}
#10回計測
foreach (1..10){
	#関数呼び出し 引数は配列ででリファレンスした$ref
	foreach (@$ref){
		&Kaprekar(@$_);
	}

}

#カプレカ数を算出する関数宣言
sub Kaprekar {
	my (@arr,@buf1,@buf2);

	foreach $cnt (@_){
		#渡された配列の要素を1桁ずつ配列に代入
		@arr = split (//,$cnt);
	
		#@arrの中身を降順にsort
		@buf1 = sort {$b <=> $a} @arr;
		#@arrの中身を昇順にsort
		@buf2 = sort {$a <=> $b} @arr;
		
		#sortした@arrの配列要素をjoinし数値として参照
		$num1 = join('', @buf1);
		$num2 = join('', @buf2);
		#渡された@arrの要素をjoinし数値として参照
		$ans_arr = join('', @arr);
	
		#カプレカ数判定
		$numnum = $num1 - $num2;

		if ($numnum == $ans_arr){
			print "$ans_arr\n";
		}
	}

}

printf("time = "."%0.3f\n",Time::HiRes::time - $start_time);  
