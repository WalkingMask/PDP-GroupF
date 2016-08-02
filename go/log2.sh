#!/bin/sh
set -e

# log2.sh
# 2016/07/27(Wed)
# Kazuki Nagamine (145725A)
# Logger to excution time of kaprekar_?.go
#  cnt = 100 : 10000000
#   log file: log_s, log_p1, log_p2

touch log_s log_p

for i in `seq 2 6`
do
  pow=`echo "10 ^ $i" | bc`
  # serial
  t=`./kaprekar_s $pow | grep sec | cut -d " " -f 1`
  echo "$pow $t" >>log_s
  # parallel
  t=`./kaprekar_p $pow | grep sec | cut -d " " -f 1`
  echo "$pow $t" >>log_p
done
