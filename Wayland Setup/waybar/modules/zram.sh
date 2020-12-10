#!/bin/bash
swap_usage=$(free -t | awk 'NR == 3 {printf(" %d%"), $3/$2*100}')
echo $swap_usage
exit
