#!/usr/bin/env bash

tail -n+2 City_tax_Records.txt | grep No > defaulters.txt

echo "Address | Tax" > output.txt
while read address;
do  
    incomes=( $(grep -w "$address" defaulters.txt | cut -d" " -f5) )
    sum=0
    for i in ${incomes[@]};
    do
        sum=$(echo "sum=$sum;sum+=$i;sum" | bc)
    done
    tax=$(echo "$sum*0.2" | bc)
    echo $address '|' $tax >> output.txt
done < <(cat defaulters.txt | cut -d" " -f2,3,4 | sort | uniq -u && cat defaulters.txt | cut -d" " -f2,3,4 | sort | uniq -d)

rm ./defaulters.txt
