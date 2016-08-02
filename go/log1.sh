#!/bin/sh
set -e

# log1.sh
# 2016/07/27(Wed)
# Kazuki Nagamine (145725A)
# Logger to excution time of kaprekar_?.go in average 10
#   Where kaprekar_?.go's num is 10000000

# serial
ave=0
n=10
for i in `seq $n`
do
  t=`./kaprekar_s 1000000 | grep sec | cut -d " " -f 1`
  ave=`echo "scale=3; $ave + $t" | bc`
done
ave=`echo "scale=3; $ave / $n" | bc`
echo "serial: $ave"

# pararell
ave=0
n=10
for i in `seq $n`
do
  t=`./kaprekar_p 1000000 | grep sec | cut -d " " -f 1`
  ave=`echo "scale=3; $ave + $t" | bc`
done
ave=`echo "scale=3; $ave / $n" | bc`
echo "pararell: $ave"
