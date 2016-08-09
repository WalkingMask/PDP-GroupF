#!/usr/bin/env perl

use strict;
use warnings;
use Parallel::ForkManager;
use Data::Dumper;
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
for $cnt (0..999999) {
    push @{$ref->[$cnt % 4]}, $cnt; 
}

#実際に中身はこうなる↓
#$ref[[0,4..][1,5..][2,6..][3,7..]]
#取り出す際はでリファレンス_@$ref 

#最大4プロセスでカプレカ数を算出
my $pm = new Parallel::ForkManager(4);

#10回計測なので単純にforeachで10回回している
foreach (1..10){

foreach (@$ref){
 my $pid = $pm->start and next; #プロセスをfork
 	#print Dumper @$_; Debug : リファレンスの中身確認
	&Kaprekar(@$_);
 
 $pm->finish; #子プロセスを終了
}
#最後のプロセスを待つ為に下記のコードが必要
$pm->wait_all_children;

}

#カプレカ数を算出する関数を定義
sub Kaprekar {
my (@arr,@buf1,@buf2);

#与えられた配列分foreachで回している
foreach $cnt (@_){
	#渡された配列の要素を1桁ずつ配列に代入
	@arr = split (//,$cnt);
	
	#@arrの中身を昇順にsort
	@buf1 = sort {$b <=> $a} @arr;
	#@arrの中身を降順にsort
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
